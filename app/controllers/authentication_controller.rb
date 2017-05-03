class AuthenticationController < ApplicationController
  skip_before_action :authenticate_api_request
  before_action :require_refresh_token, only: [:refresh_token]

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success? 
      render json: { token: command.result }
    else 
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def refresh_token
  	command = RefreshToken.call(@token)
  	if command.success?
  	  render json: { token: command.result }
  	else
  	  render json: { error: command.errors }, status: 400
  	end
  end

  private

  def require_refresh_token
  	return @token if @token
  	unless params[:token].present?
  	  render json: { error: "Invalid data" }
  	  return
  	else
  	  @token = params[:token]
  	end
  end
end
