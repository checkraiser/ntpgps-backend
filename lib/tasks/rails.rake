namespace :rails do 
	desc 'stop rails'
	task :stop => :environment do
	    pid_file = 'tmp/pids/server.pid'
	    pid = File.read(pid_file).to_i
	    Process.kill 9, pid
	    File.delete pid_file
	end

  desc 'clean locations'
  task :clean_location => :environment do
    Location.where(address: nil).delete_all
    CheckIn.where(address: nil).delete_all
    CheckOut.where(address: nil).delete_all
    User.all.each do |user|
      location = user.locations.last
      user.update! latitude: l.latitude, longitude: l.longitude, update_location_at: l.created_at
    end
  end
end
