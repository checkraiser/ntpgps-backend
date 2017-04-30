require 'test_helper'

class UpdateUsersOnlineStatusTest < ActiveSupport::TestCase
  test "success" do 
    create_user

    UpdateUsersOnlineStatus.call

    p User.all
  end

  def create_user
    CreateUser.call "Dung", "dungth@hpu.edu.vn", "123123123", "123123123", "Hai Phong"
    u = User.last
    u.update update_location_at: 1.minute.ago
  end
end