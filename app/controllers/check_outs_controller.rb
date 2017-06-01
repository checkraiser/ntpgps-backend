class CheckOutsController < ApplicationController
  def index
  	render json: current_user.check_outs
  end

  def create
  	command = CreateCheckOut.call(current_user, params[:latitude], params[:longitude], params[:percentage], params[:time])
    if command.success? 
      render json: { code: 201, result: command.result }
    else 
      render json: { code: 402, error: command.errors }
    end
  end

  def queue
    command = CreateQueueCheckOuts.call(
      current_user: current_user, check_outs: params[:check_outs]
    )
    if command.success?
        render json: { code: 204 }, status: 204
    else
      render json: { error: command.errors }, status: 400 
    end
  end
end
