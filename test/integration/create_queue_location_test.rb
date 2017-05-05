require 'test_helper'

class CreateQueueLocationTest < ActiveSupport::TestCase
  test 'create queue location' do
    user = CreateUser.call(Faker::Name.name, Faker::Internet.email, '123123123', '123123123', Faker::Address.street_name).result
    command = CreateQueueLocation.call(user, Faker::Address.latitude, Faker::Address.longitude, 93, 1.minute.ago)
    assert command.pre_condition
    assert command.post_condition
    assert command.result, Location.last
  end
end