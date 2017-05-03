class UpdateUserGeo
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @percentage = percentage
  end

  def call
    old_online_status = @user.online_status
  	@user.assign_attributes latitude: @latitude, 
                            longitude: @longitude, 
                            percentage: @percentage,
                            online_status: !old_online_status,
                            update_location_at: Time.current
    return @user if @user.save
     errors.merge(@user.errors)
  rescue => e
  	errors.add :update_user_geo, e.message
  end
end
