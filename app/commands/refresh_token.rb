class RefreshToken
  include SimpleCommand

  def initialize(old_token)
  	@old_token = old_token
  end

  def call
  	refresh_token
  end

  private

  attr_accessor :old_token 

  def refresh_token
  	command = user = AuthorizeApiRequest.call(old_token)
  	if command.success?
  	  JsonWebToken.encode(user_id: user.id) if user
  	else
  	  errors.add :refresh_token, "Error refresh token"
  	end
  end
end
