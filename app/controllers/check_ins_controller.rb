class CheckInsController < ApplicationController
  def index
  	render json: current_user.check_ins
  end

  def create
  	command = CreateCheckIn.call(current_user, params[:latitude], params[:longitude])
    if command.success? 
      check_in = command.result
      result = { name: check_in.user.name, checked_in_time: check_in.created_at, address: check_in.address }
      render json: { code: 200 }
    else 
      render json: { code: 400 }
    end
  end
end