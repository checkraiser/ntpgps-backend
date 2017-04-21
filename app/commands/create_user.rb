class CreateUser
  prepend SimpleCommand

  def initialize(name, email, password, password_confirmation, address, admin = false)
  	@address = address
  	@name = name
  	@email = email
  	@password = password
  	@password_confirmation = password_confirmation
  	@admin = admin
  end

  def call
  	user
  end

  private

  attr_accessor :address, :name, :email, :password, :password_confirmation, :admin

  def user
  	user = User.find_by_email(email)
  	errors.add :create_user, 'User exists' if user
  	user = User.new name: name,
				  email: email,
				  password: password,
				  password_confirmation: password_confirmation,
				  admin: admin,
				  address: address
	geo = Geocoder.search(address)				  
	unless geo.empty?
		user.latitude = geo[0].data["lat"]
		user.longitude = geo[0].data["lon"]
	end
	if user.save  					  
	  user
  	else
  	  user.errors
  	end
  end
end
