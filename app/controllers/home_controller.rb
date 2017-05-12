class HomeController < ApplicationController
  def index
    if logged_in?
  	   authorize_admin! 
       load_data
       @home_page = true
       @groups = Group.all
    end
  end

  private

  def load_data
    @positions ||= pluck(decorate(users), :id, :latitude, :longitude, :info, :icon_path, :title)
    @center ||= Geocoder::Calculations.geographic_center users.pluck(:latitude, :longitude)
    @users ||= Kaminari.paginate_array(check_ins).page(params[:page]).per(10)
    @online ||= users.online.count
    @offline ||= users.offline.count
  end

  def check_ins
    @check_ins ||= Api::V1::HistoryCheckInOutQuery.new(params).render
  end

  def check_ins_ids
    check_ins.map { |item| item[:user_id] }
  end

  def users
    User.where(id: check_ins_ids)
  end
end
