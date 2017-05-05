require 'test_helper'

class CheckOutTest < ActiveSupport::TestCase
  test 'create check_out' do
    # create check_in => create_location => update_user current location
    user = CreateUser.call(Faker::Name.name, Faker::Internet.email, '123123123', '123123123', Faker::Address.street_name).result
    check_in = CreateCheckOut.call(user, Faker::Address.latitude, Faker::Address.longitude).result
    assert User.last.id, user.id
    assert CheckOut.last, check_in
    assert Location.last, user.locations.last
  end
end
