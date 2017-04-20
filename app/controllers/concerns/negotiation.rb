module Negotiation
  extend ActiveSupport::Concern

  private

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