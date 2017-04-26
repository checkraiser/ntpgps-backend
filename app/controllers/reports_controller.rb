class ReportsController < ApplicationController
  before_action :authorize_admin!

  def export
  	#select1 = "users.id as uid, check_ins.address as ci_address, check_ins.created_at::date as ci_date, to_char(check_ins.created_at, 'HH24:MI') as ci_time"
  	#select2 = "check_outs.address as co_address, check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time"
  	#@reports = User.joins(:check_ins).select(select1).joins(:check_outs).select(select2)
  	sql = "select users.id as uid, check_ins.address as ci_address, check_ins.created_at::date as ci_date, to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time 
  	from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
  	inner join users on check_ins.user_id=users.id
  	order by check_ins.created_at"
  	
  	@reports = CheckIn.find_by_sql(sql)
  end
end
