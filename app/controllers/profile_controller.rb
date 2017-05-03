class ProfileController < ApplicationController
  def current_info
    render json: CheckIn.find_by_sql(sql)
  end

  def history_info
    render json: CheckIn.find_by_sql(all_sql)
  end

  private

  def sql
    @sql ||= "select users.id as uid, users.name as name, check_ins.address as ci_address, check_ins.created_at::date as ci_date, to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time 
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    where users.id = #{current_user.id}    
    and to_char(check_ins.created_at, 'YYYY-MM-DD')  = to_char( now(), 'YYYY-MM-DD' )
    order by check_ins.created_at
    limit 1"
  end

  def all_sql
    @sql ||= "select users.id as uid, users.name as name, check_ins.address as ci_address, check_ins.created_at::date as ci_date, to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time 
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    where users.id = #{current_user.id}    
    order by check_ins.created_at"
  end
end
