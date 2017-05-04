class ProfileController < ApplicationController
  def current_info
    infos = CheckIn.find_by_sql(sql)
    if infos.length == 0
      infos = [empty_info]
    else
      infos = infos.as_json.map do |i|
        i["avatar"] = avatar
        i
      end
    end
    render json: infos[0]
  end

  def history_info
    infos = CheckIn.find_by_sql(all_sql)
    infos = infos.as_json.map do |i|
      i["avatar"] = avatar
      i
    end
    render json: infos
  end

  private

  def sql
    @sql ||= "select users.id as uid, 
      to_char(check_ins.created_at, 'DD/MM') as current_date, 
      users.name as name, 
      check_ins.address as ci_address, 
      to_char(check_ins.created_at, 'DD-MM-YYYY') as ci_date, 
      to_char(check_ins.created_at, 'HH24:MI') as ci_time, 
      check_outs.address as co_address, 
      to_char(check_outs.created_at::date, 'DD-MM-YYYY') as co_date, 
      to_char(check_outs.created_at, 'HH24:MI') as co_time 
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    where users.id = #{current_user.id}    
    and to_char(check_ins.created_at, 'DD-MM-YYYY')  = to_char( now(), 'DD-MM-YYYY' )
    order by check_ins.created_at"
  end

  def all_sql
    @sql ||= "select users.id as uid, 
      to_char(check_ins.created_at, 'DD/MM') as current_date, 
      users.name as name, 
      check_ins.address as ci_address, 
      to_char(check_ins.created_at, 'DD-MM-YYYY') as ci_date, 
      to_char(check_ins.created_at, 'HH24:MI') as ci_time, 
      check_outs.address as co_address, 
      to_char(check_outs.created_at::date, 'DD-MM-YYYY') as co_date, 
      to_char(check_outs.created_at, 'HH24:MI') as co_time 
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    where users.id = #{current_user.id}    
    order by check_ins.created_at"
  end

  def avatar
    @avatar ||= ActionController::Base.helpers.asset_url('avatar.jpg')
  end

  def empty_info
    {"id":"", avatar: avatar, "uid": current_user.id ,"current_date":Date.current.strftime("%d/%m"),"name":current_user.name,"ci_address":"","ci_date":"","ci_time":"","co_address":"","co_date":"","co_time":""}
  end
end
