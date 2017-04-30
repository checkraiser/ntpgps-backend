class HomeController < ApplicationController
  def index
    if logged_in?
  	   authorize_admin! 
       load_data
    end    
  end

  private

  def load_data
    @positions = pluck(decorate(User.all), :id, :latitude, :longitude, :info, :icon_path, :title)
    @center = Geocoder::Calculations.geographic_center User.pluck(:latitude, :longitude)
    @users = User.where.not(admin: true)
  end
end
