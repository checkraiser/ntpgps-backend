class AuthorizeLogin
  prepend SimpleCommand

  def initialize(session)
  	@session = session
  end

  def call
    user    
  end

  private

  attr_accessor :session

  def user
  	@user = User.find_by_id(session[:user_id])
  	@user || errors.add(:session, 'Invalid session') && nil
  end
end