class CheckInsController < ApplicationController
  def index
  	render json: current_user.check_ins
  end

  def create
  	command = CreateCheckIn.call(current_user, params[:latitude], params[:longitude], params[:percentage])
    if command.success? 
      render json: { code: 200 }
    else 
      render json: { code: 400 }
    end
  end
end
