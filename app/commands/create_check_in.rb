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
    if check_in.save
      UpdateUserGeo.call(@user, @latitude, @longitude, nil)
      return check_in
    else
      check_in.errors
    end
  rescue => e
  	errors.add :create_check_in, e.message
  end
end
