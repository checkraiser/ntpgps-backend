require 'faker'

after "development:users" do
User.all.each do |u|
  3.times do 
    CreateLocation.call u, Faker::Address.latitude, Faker::Address.longitude  
  end
end
end