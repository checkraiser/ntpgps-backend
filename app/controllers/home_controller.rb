class HomeController < ApplicationController
  def index
    if logged_in?
  	   authorize_admin! 
       load_data
    end    
  end

  private

  def load_data
    @positions ||= pluck(decorate(User.all), :id, :latitude, :longitude, :info, :icon_path, :title)
    @center ||= Geocoder::Calculations.geographic_center User.pluck(:latitude, :longitude)
    @users ||= CheckIn.find_by_sql(sql_all)
    @online ||= User.online.count
    @offline ||= User.offline.count
  end


  def sql_all
    @sql ||= "select users.id as uid, users.name as name, 
    check_ins.address as ci_address, check_ins.created_at::date as ci_date, 
    to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, 
    check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time,
    users.online_status, users.percentage
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    order by check_ins.created_at"
  end
end
