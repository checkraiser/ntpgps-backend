require 'test_helper'

class CreateLocationTest < ActiveSupport::TestCase
  test 'create location' do
    user = CreateUser.call(Faker::Name.name, Faker::Internet.email, '123123123', '123123123', Faker::Address.street_name).result
    location = CreateLocation.call(user, Faker::Address.latitude, Faker::Address.longitude, 93)
    assert User.last, user
    assert user.locations, location.result
  end

  test 'fail' do
    location = CreateLocation.call(nil, Faker::Address.latitude, Faker::Address.longitude, 93)
    assert location.errors, {:user=>[:blank]}
  end
end