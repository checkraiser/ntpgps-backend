class CheckOutsController < ApplicationController
  def index
  	render json: current_user.check_outs
  end

  def create
  	command = CreateCheckOut.call(current_user, params[:latitude], params[:longitude])
    if command.success? 
      render json: { check_in: command.result } 
    else 
      render json: { error: command.errors }, status: :unauthorized 
    end
  end
end