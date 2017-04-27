module Authentication
  extend ActiveSupport::Concern

  included do 
    before_action :authenticate_api_request, if: :json_request?
    before_action :login_required, if: :html_request?
    helper_method :logged_in?
    helper_method :current_user
  end

  private

  def authenticate_api_request 
  	@current_user = AuthorizeApiRequest.call(request.headers).result 
  	render json: { error: 'Not Authorized' }, status: 401 unless logged_in?
  end

  def login_required
    if !logged_in?
      redirect_to login_path
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
  	@current_user ||= AuthorizeLogin.call(session).result
  end
end