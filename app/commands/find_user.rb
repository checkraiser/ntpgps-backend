class FindUser
  prepend SimpleCommand

  def initialize(user_id)
  	@user_id = user_id
  end

  def call
  	u = User.find_by_id(@user_id)
    return u if u 
    errors.add :find_user, "User not found"
  rescue => e
  	errors.add :find_user, e.message
  end
end
