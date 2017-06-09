class CreateCheckOut
  prepend SimpleCommand

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
    check_out = user.check_outs.at(update_location_at.to_date).first
    errors.add :create_check_out, 'Check Out exists' if check_out
    unless check_out
      User.transaction do
        user.update! latitude: latitude, 
                     longitude: longitude, 
                     online_status: true,
                     percentage: percentage,
                     update_location_at: update_location_at
        check_out = user.check_outs.create!  latitude: latitude,
                                             longitude: longitude,
                                             percentage: percentage,
                                             created_at: update_location_at
        last_location = user.locations.create! latitude: latitude,
                               longitude: longitude,
                               percentage: percentage,
                               created_at: update_location_at
        #user.update! address: address unless user.address
        #check_out.update! address: address unless check_out.address
        #last_location.update! address: address unless last_location.address                                                 
        Report.refresh                               
      end
    end
  rescue => e
    errors.add :create_check_out, e.message
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

  attr_accessor :check_out, :user, :latitude, :longitude, :update_location_at, :percentage
end
