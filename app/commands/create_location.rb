class CreateLocation
  prepend SimpleCommand
  include ActiveModel::Model

  validates :user, :latitude, :longitude, presence: true

  def initialize(user, latitude, longitude, percentage, update_location_at)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @percentage = percentage
    if !update_location_at 
      @update_location_at = Time.current.in_time_zone
    elsif update_location_at && update_location_at.is_a?(String)
      @update_location_at = Time.zone.parse(update_location_at)
    else
      @update_location_at = update_location_at
    end
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
      #user.update! address: address unless user.address                   
      #location.update! address: address unless location.address                                     
      return location                   
    end
  rescue => e
    errors.add :create_location, e.message
    nil
  end

  def address
    @address ||= to_address(geocoder.search(latitude, longitude))
  end

  def geocoder
    @geocoder ||= OfflineGeocoder.new
  end

  def to_address(res)
    "#{res[:name]} #{res[:admin1]}, #{res[:admin2]}, #{res[:country]}" 
  end

  attr_accessor :location, :user
  attr_reader :latitude, :longitude, :percentage, :update_location_at  
end
