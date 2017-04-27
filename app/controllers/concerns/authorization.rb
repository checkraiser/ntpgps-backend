module Authorization
  extend ActiveSupport::Concern

  included do     
  	helper_method :admin?
  end

  private

  def authorize_admin!
  	if json_request?
  		render_json_error  unless admin?
  	else
  		redirect_to login_path, notice: "Please login" unless  admin?
  	end
  end

  def admin?
  	current_user && current_user.admin?
  end

  def render_json_error
  	render json: { error: 'Not Authorized' }, status: 401
  end
end