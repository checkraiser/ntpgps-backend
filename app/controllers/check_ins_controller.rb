class CheckInsController < ApplicationController
  def index
  	render json: current_user.check_ins
  end

  def create
  	command = CreateCheckIn.call(current_user, params[:latitude], params[:longitude], params[:percentage], params[:time])
    if command.success? 
      render json: { code: 200, result: command.result }
    else 
      render json: { code: 400, error: command.errors }
    end
  end

  def queue
    command = CreateQueueCheckIns.call(
      current_user: current_user, check_ins: params[:check_ins]
    )
    if command.success?
        render json: { code: 204 }, status: 204
    else
      render json: { error: command.errors }, status: 400 
    end
  end
end
