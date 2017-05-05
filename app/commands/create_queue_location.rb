class CreateQueueLocation
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage, time)
    @user = user
    @pre_locations = @user.locations.count
    @latitude = latitude
    @longitude = longitude
    @percentage = percentage
    @time = time
  end

  def call
    create_queue_location
  end

  attr_accessor :pre_condition, :post_condition

  private

  def check_precondition
    raise UserNotFound unless user
    @pre_condition = true
  end

  def check_postcondition
    raise StandardError, 'invalid state' unless (user.locations.count - pre_locations == 1)
    @post_condition = true
  end

  def create_queue_location
    check_precondition
    Location.transaction do 
      location = user.locations.create! latitude: latitude,
                                        longitude: longitude,
                                        percentage: percentage,
                                        created_at: time
      user.update! latitude: latitude,
                   longitude: longitude,
                   update_location_at: time,
                   online_status: true,
                   percentage: percentage        
      check_postcondition
      return location
    end
  rescue => e
    errors.add :create_queue_location, e.message
    nil
  end

  attr_reader :user, :latitude, :longitude, :percentage, :time  
  attr_reader :pre_locations  
  attr_accessor :location

  class UserNotFound < StandardError
    def initialize(msg = 'User was not found')
      super
    end
  end
end
