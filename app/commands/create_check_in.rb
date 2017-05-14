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
        last_location = user.locations.create! latitude: latitude,
                                               longitude: longitude,
                                               percentage: percentage,
                                               created_at: update_location_at
        user.update! address: address unless user.address
        check_in.update! address: address unless check_in.address
        last_location.update! address: address unless last_location.address                  
        Report.refresh                               
      end
    end
  rescue => e
  	errors.add :create_check_in, e.message
  end

  private

  def address
    @address ||= to_address(geocoder.search(latitude, longitude))
  end

  def geocoder
    @geocoder ||= OfflineGeocoder.new
  end

  def to_address(res)
    "#{res[:name]} #{res[:admin1]}, #{res[:admin2]}, #{res[:country]}" 
  end
  
  attr_accessor :check_in, :user, :latitude, :longitude, :update_location_at, :percentage
end
