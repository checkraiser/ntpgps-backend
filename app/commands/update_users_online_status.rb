class UpdateUsersOnlineStatus
  prepend SimpleCommand

  def initialize
    @users = User.all
  end

  def call
    return [] if users.empty?
    res = []
    users.each do |user|
      command = UpdateOnlineStatus.call(user)
      if command.success?
        res << command.result
      end
    end
    Report.refresh
    res
  end

  private

  attr_accessor :users
end
