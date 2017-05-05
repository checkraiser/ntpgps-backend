require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  test 'create checkin' do
    # create check_in => create_location => update_user current location
    user = CreateUser.call(Faker::Name.name, Faker::Internet.email, '123123123', '123123123', Faker::Address.street_name).result
    check_in = CreateCheckIn.call(user, Faker::Address.latitude, Faker::Address.longitude).result
    assert User.last.id, user.id
    assert CheckIn.last, check_in
    assert Location.last, user.locations.last
  end
end
