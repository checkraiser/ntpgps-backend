class LocationsController < ApplicationController
  def index
    @center = center
	  render json: marker_locations(locations)
  end

  def create
    command = CreateLocation.call(current_user, params[:latitude], params[:longitude])
    if command.success?
    	  ActionCable.server.broadcast 'locations',
          position: [current_user.id, params[:latitude], params[:longitude]],
          center: center
        head 204
    else
      render json: { error: command.errors }, status: 400 
    end
  end

  private

  def locations
    User.select(:latitude, :longitude, :email)
  end

  def center
    Geocoder::Calculations.geographic_center User.pluck(:latitude, :longitude)
  end

  def direction(user)
    "User #{user.email}: #{user.address}"
  end

  def marker_locations(locations)
  	Gmaps4rails.build_markers(locations) do |location, marker|
  	  marker.lat location.latitude
  	  marker.lng location.longitude
      marker.json({ :user_id => location[:user_id] })
      marker.infowindow location[:user_email]
  	end
  end
end
