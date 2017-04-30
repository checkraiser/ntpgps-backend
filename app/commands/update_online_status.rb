class UpdateOnlineStatus
  prepend SimpleCommand

  def initialize(user)
    @user = user
  end

  def call
    if (Time.now - user.update_location_at > 5.minutes)
      user.assign_attributes online_status: false      
    else
      user.assign_attributes online_status: true
    end
    if user.save
      user
    end
  end

  private

  attr_accessor :user
end
