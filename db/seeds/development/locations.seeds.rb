require 'faker'

u = User.first
100.times do 
  u.locations.create latitude: Faker::Address.latitude, longitude: Faker::Address.longitude  
end