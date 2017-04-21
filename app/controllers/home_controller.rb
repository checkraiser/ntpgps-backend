class HomeController < ApplicationController
  skip_before_action :login_required

  def index
  	if logged_in?
      @positions = positions
      @center = center
  	end
  end

  private

  def positions
    User.pluck(:id, :latitude, :longitude)
  end

  def center
    Geocoder::Calculations.geographic_center User.pluck(:latitude, :longitude)
  end
end
