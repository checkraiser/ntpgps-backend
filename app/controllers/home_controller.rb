class HomeController < ApplicationController
  skip_before_action :login_required

  def index
    if logged_in?
  	   authorize_admin! 
       load_data
    end    
  end

  private

  def load_data
    @positions = pluck(decorate(User.all), :id, :latitude, :longitude, :info)
    @center = Geocoder::Calculations.geographic_center User.pluck(:latitude, :longitude)
    @users = User.where.not(admin: true)
  end
end
