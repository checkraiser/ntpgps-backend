require 'faker'

3.times do |i|
  User.create!(name: "Dung", email: "example_#{i}@mail.com" , password: '123123123' , password_confirmation: '123123123')
end
