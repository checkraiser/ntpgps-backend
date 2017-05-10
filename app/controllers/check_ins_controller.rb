class CheckInsController < ApplicationController
  def index
  	render json: current_user.check_ins
  end

  def create
  	command = CreateCheckIn.call(current_user, params[:latitude], params[:longitude], params[:percentage])
    if command.success? 
      render json: { code: 200, result: command.result }
    else 
      render json: { code: 400, error: command.errors }
    end
  end
end
