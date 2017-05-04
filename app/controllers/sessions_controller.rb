class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
  	command = LoginUser.call(params[:email], params[:password])
    if command.success? 
      session[:user_id] = command.result.id
      redirect_to root_path, :notice => "Welcome back"
    else 
      flash.now.alert = "Tài khoản không đúng. Vui lòng thử lại."
      render "new"
    end
  end

  def destroy
  	session[:user_id] = nil
    redirect_to root_path
  end
end
