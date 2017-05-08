class CreateCheckIn
  prepend SimpleCommand

  def initialize(user, latitude, longitude, update_location_at = Time.current)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @update_location_at = update_location_at
  end

  def call
    check_in = user.check_ins.at(update_location_at.to_date).first
    
    unless check_in
      User.transaction do
        user.update! latitude: latitude, 
                     longitude: longitude, 
                     online_status: true,
                     update_location_at: update_location_at
      	check_in = user.check_ins.create!  latitude: latitude,
      						   			                 longitude: longitude,
                                           created_at: update_location_at
        user.locations.create! latitude: latitude,
                               longitude: longitude,
                               created_at: update_location_at
      end
    end
    check_in
  rescue => e
  	errors.add :create_check_in, e.message
  end

  private
  
  attr_accessor :check_in, :user, :latitude, :longitude, :update_location_at
end
