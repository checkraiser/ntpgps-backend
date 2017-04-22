module Negotiation
  extend ActiveSupport::Concern

  private

  def require_json_request!
    unless json_request?
      render json: { error: 'Not Authorized' }, status: 401
      return
    end
  end

  def json_request?
    request.format.json? || json_header?
  end

  def json_header?
  	request.headers['Content-Type'].present? &&
  		request.headers['Content-Type'] == 'application/json'
  end

  def html_request?
  	request.format.html?
  end
end