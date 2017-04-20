module Authorization
  extend ActiveSupport::Concern

  private

  def authorize_admin!
  	render json: { error: 'Not Authorized' }, status: 401 unless @current_user.admin?
  end
end