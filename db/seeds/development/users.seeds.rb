require 'faker'

100.times do |i|
  u = User.create!(email: "example_#{i}@mail.com" , password: '123123123' , password_confirmation: '123123123')
  u.locations.create latitude: Faker::Address.latitude, longitude: Faker::Address.longitude  
end
