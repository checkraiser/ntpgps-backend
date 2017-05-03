class CreateLocation
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @percentage = percentage
  end

  def call
  	location = @user.locations.build  latitude: @latitude,
  						   			                longitude: @longitude,
                                      percentage: @percentage
    if location.save
      UpdateUserGeo.call(@user, @latitude, @longitude, @percentage)
    else
      location.errors
    end
  rescue => e
  	errors.add :create_location, e.message
  end
end
