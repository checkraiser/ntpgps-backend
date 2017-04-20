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
    return check_out if check_out.save
     errors.merge(check_out.errors)
  rescue => e
  	errors.add :create_check_out, e.message
  end
end
