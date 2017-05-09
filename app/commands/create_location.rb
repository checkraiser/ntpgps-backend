class CreateLocation
  prepend SimpleCommand
  include ActiveModel::Model

  validates :user, :latitude, :longitude, presence: true

  def initialize(user, latitude, longitude, percentage, update_location_at = Time.current.in_time_zone)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @percentage = percentage
    @update_location_at = update_location_at
  end

  def call
    return nil unless valid?
    create_location
  end
  

  private

  def create_location
    Location.transaction do 
      location = user.locations.create!  latitude: latitude,
                                         longitude: longitude,
                                         percentage: percentage,
                                         created_at: update_location_at
                                         
      user.update! latitude: latitude,
                   longitude: longitude,
                   update_location_at: update_location_at,
                   online_status: true,
                   percentage: percentage
      return location                   
    end
  rescue => e
    errors.add :create_location, e.message
    nil
  end


  attr_accessor :location, :user
  attr_reader :latitude, :longitude, :percentage, :update_location_at  
end
