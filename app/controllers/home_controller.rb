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
    @users ||= Kaminari.paginate_array(check_ins).page(params[:page]).per(20)
    @online ||= users.online.count
    @offline ||= users.offline.count
  end

  def check_ins
    if params[:group_id].present?
      CheckIn.find_by_sql(sql_with_group_id(params[:group_id], params[:query]))
    else
      CheckIn.find_by_sql(sql_all(params[:query]))
    end
  end

  def check_ins_ids
    check_ins.map { |item| item[:uid] }
  end

  def users
    User.where(id: check_ins_ids)
  end

  def sql_all(query)
    @sql ||= "select users.id as uid, users.name as name, 
    check_ins.address as ci_address, check_ins.created_at::date as ci_date, 
    to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, 
    check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time,
    users.online_status, users.percentage
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    and users.name like '%#{query}%' or users.email like '%#{query}%'
    order by check_ins.created_at"
  end

  def sql_with_group_id(group_id, query)
    @sql ||= "select users.id as uid, users.name as name, 
    check_ins.address as ci_address, check_ins.created_at::date as ci_date, 
    to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, 
    check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time,
    users.online_status, users.percentage
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    inner join user_groups on user_groups.user_id = users.id
    where user_groups.group_id = #{group_id}
    and users.name like '%#{query}%' or users.email like '%#{query}%'
    order by check_ins.created_at"
  end
end
