class UpdateUserGeo
  prepend SimpleCommand

  def initialize(user, latitude, longitude)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
  end

  def call
  	@user.assign_attributes latitude: @latitude, longitude: @longitude
    return @user if @user.save
     errors.merge(@user.errors)
  rescue => e
  	errors.add :update_user_geo, e.message
  end
end
