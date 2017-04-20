class CreateCheckIn
  prepend SimpleCommand

  def initialize(user, latitude, longitude)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
  end

  def call
  	check_in = @user.check_ins.build  latitude: @latitude,
  						   			  longitude: @longitude
    return check_in if check_in.save
     errors.merge(check_in.errors)
  rescue => e
  	errors.add :create_check_in, e.message
  end
end
