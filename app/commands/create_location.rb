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
    if location.save
      UpdateUserGeo.call(@user, @latitude, @longitude)
    else
      location.errors
    end
  rescue => e
  	errors.add :create_location, e.message
  end
end
