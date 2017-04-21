class UsersController < ApplicationController
  before_action :authorize_admin!

  def index
    @users = User.all
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

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @position = current_position
    #@center = [current_position[1], current_position[2]]
  end

  private

  def current_position
    [user.latitude, user.longitude]
  end

  def user
    return @user if @user
    command = FindUser.call(params[:id])
    if command.success?
      @user = command.result
    else
      redirect_to root_path, error: command.errors
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :admin)
  end
end
