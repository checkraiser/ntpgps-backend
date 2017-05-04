class CreateQueueLocation
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage, time)
    @user = user
    @latitude = latitude
    @longitude = longitude
    @percentage = percentage
    @time = time
  end

  def call
    location = @user.locations.build  latitude: @latitude,
                                      longitude: @longitude,
                                      percentage: @percentage,
                                      created_at: @time
    if location.save
      UpdateUserGeo.call(@user, @latitude, @longitude, @percentage, @time)
    else
      location.errors
    end
  rescue => e
    errors.add :create_location, e.message
  end
end
