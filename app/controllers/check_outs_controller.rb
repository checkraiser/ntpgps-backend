class CheckOutsController < ApplicationController
  def index
  	render json: current_user.check_outs
  end

  def create
  	command = CreateCheckOut.call(current_user, params[:latitude], params[:longitude])
    if command.success? 
      check_out = command.result
      result = { name: check_out.user.name, checked_in_time: check_out.created_at, address: check_out.address }
      render json: { code: 201 }
    else 
      render json: { code: 402 }
    end
  end
end