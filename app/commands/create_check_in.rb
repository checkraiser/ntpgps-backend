class CreateCheckIn
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage, update_location_at)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @percentage = percentage
    @update_location_at = update_location_at || Time.current.in_time_zone
  end

  def call
    check_in = user.check_ins.at(update_location_at.to_date).first
    errors.add :create_check_in, 'Check In exists' if check_in
    unless check_in
      User.transaction do
        user.update! latitude: latitude, 
                     longitude: longitude, 
                     online_status: true,
                     percentage: percentage,
                     update_location_at: update_location_at
      	check_in = user.check_ins.create!  latitude: latitude,
      						   			                 longitude: longitude,
                                           percentage: percentage,
                                           created_at: update_location_at
        user.locations.create! latitude: latitude,
                               longitude: longitude,
                               percentage: percentage,
                               created_at: update_location_at
        Report.refresh                               
      end
    end
  rescue => e
  	errors.add :create_check_in, e.message
  end

  private
  
  attr_accessor :check_in, :user, :latitude, :longitude, :update_location_at, :percentage
end
