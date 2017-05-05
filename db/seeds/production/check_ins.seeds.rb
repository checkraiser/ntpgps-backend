require 'faker'

def range (min, max)
  rand * (max-min) + min
end

def latest_update_time(user)
  user.update_location_at.strftime("%d/%m/%Y %H:%M")
end

def info(user)
  "#{user.name} - #{latest_update_time(user)}"
end
after "development:users" do
  today = Time.current
  lat = 20.870855
  lng = 106.7102486
  User.all.each do |u|
    10.times do |t|
      lat2 = range(18, 22)
      lng2 = range(106, 107)
      CreateCheckIn.call u, lat2, lng2, today + (t.days)
    end
  end
end
