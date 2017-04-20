class CreateCheckOut
  prepend SimpleCommand

  def initialize(user, latitude, longitude)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
  end

  def call
  	check_out = @user.check_outs.build  latitude: @latitude,
  						   			                 longitude: @longitude
    if check_out.save
      UpdateUserGeo.call(@user, @latitude, @longitude)
    else
      errors.merge(check_out.errors)
    end
  rescue => e
  	errors.add :create_check_out, e.message
  end
end
