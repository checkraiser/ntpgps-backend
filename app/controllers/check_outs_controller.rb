class CheckOutsController < ApplicationController
  def index
  	render json: current_user.check_outs
  end

  def create
  	command = CreateCheckOut.call(current_user, params[:latitude], params[:longitude], params[:percentage])
    if command.success? 
      render json: { code: 201 }
    else 
      render json: { code: 402 }
    end
  end
end