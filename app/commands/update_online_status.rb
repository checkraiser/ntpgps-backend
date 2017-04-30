class UpdateOnlineStatus
  prepend SimpleCommand

  def initialize(user)
    @user = user
  end

  def call
    if (Time.now - user.update_location_at > 5.minutes)
      user.assign_attributes online_status: false
      if user.save
        user
      end
    end
  end

  private

  attr_accessor :user
end
