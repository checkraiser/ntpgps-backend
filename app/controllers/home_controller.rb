class HomeController < ApplicationController
  skip_before_action :login_required

  def index
  	if logged_in?
  		location_ids = Location.group(:user_id).maximum(:id).values
  		locations = Location.where(id: location_ids).includes(:user).limit(3)
  		@hash = Gmaps4rails.build_markers(locations) do |location, marker|
  		  marker.lat location.latitude
  		  marker.lng location.longitude
        marker.json({ :user_id => location.user_id })
        marker.infowindow "#{location.user.email} - #{location.latitude}, #{location.longitude}"
  		end
  	end
  end
end
