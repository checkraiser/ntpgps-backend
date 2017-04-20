class CreateLocation
  prepend SimpleCommand

  def initialize(user, latitude, longitude)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
  end

  def call
  	location = @user.locations.build  latitude: @latitude,
  						   			                longitude: @longitude
    return location if location.save
     errors.merge(location.errors)
  rescue => e
  	errors.add :create_location, e.message
  end
end
