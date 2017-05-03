class UsersController < ApplicationController
  before_action :authorize_admin!
  before_action :require_user, only: [:show, :report, :update_groups]
  helper_method :user_geo

  def index
    @users = User.all
  end

  def show
    @reports = CheckIn.find_by_sql(sql(user))
  end

  def new
  end

  def create
    command = CreateUser.call(
      user_params[:name], 
      user_params[:email], 
      user_params[:password], 
      user_params[:password_confirmation], 
      user_params[:address], 
      user_params[:admin]
    )
    if command.success?
      redirect_to users_path, success: "User created"
    else
      @form_error = command.errors
      render :new
    end
  end

  def update_groups
    command = SetUserGroups.call(user.id, group_ids)
    if command.success?
      redirect_to users_path, success: "Groups updated successfully"
    else
      redirect_to users_path, error: command.errors
    end
  end

  def destroy
  end

  def report
    @reports = CheckIn.find_by_sql(sql)
  end

  private

  def current_position
    @current_position ||= [user.latitude, user.longitude]
  end

  def require_user
    return @user if @user
    command = FindUser.call(params[:id])
    if command.success?
      @user = command.result
    else
      redirect_to root_path, error: command.errors
    end
  end

  def user
    decorate(@user)
  end

  def user_geo
    {
      lat: user.lat,
      lng: user.lng,
      info: user.info,
      icon_path: user.icon_path,
      title: user.title,
      histories: histories
    }
  end

  def from_date
    params[:from_date].present? ? DateTime.strptime(params[:from_date], "%m/%d/%Y") : Date.current    
  end

  def to_date
    params[:to_date].present? ? DateTime.strptime(params[:to_date], "%m/%d/%Y") : Date.current
  end

  def histories
    p user.locations.date(from_date, to_date)
    user.locations.date(from_date, to_date).pluck(:latitude, :longitude, :address, :id, :created_at).compact.uniq.map do |item|
      { lat: item[0], lng: item[1], address: item[2], id: item[3], created_at: item[4].strftime("%d/%m/%Y %H:%M") }
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :admin)
  end

  def group_ids
    params[:group_ids]
  end

  def geo_users
    @users ||= User.where(id: user.id)
  end

  def sql(user)
    @sql ||= "select users.id as uid, check_ins.address as ci_address, check_ins.created_at::date as ci_date, to_char(check_ins.created_at, 'HH24:MI') as ci_time, check_outs.address as co_address, check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time 
    from check_ins left outer join check_outs on check_ins.user_id=check_outs.user_id and date_trunc('day',check_ins.created_at)=date_trunc('day',check_outs.created_at)
    inner join users on check_ins.user_id=users.id
    where users.id = #{user.id}
    order by check_ins.created_at"
  end

  helper_method :user
end
