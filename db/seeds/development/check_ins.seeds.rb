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
      lat2_in = range(18, 22)
      lng2_in = range(106, 107)
      lat2_out = range(18, 22)
      lng2_out = range(106, 107)
      CreateCheckIn.call u, lat2_in, lng2_in, 100, today + (t.days)
      CreateCheckOut.call u, lat2_out, lng2_out, 80, today + (t.days)
    end
  end
end
