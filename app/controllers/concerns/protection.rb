module Protection
  extend ActiveSupport::Concern

  included do 
  	protect_from_forgery
  	skip_before_action :verify_authenticity_token, if: :json_request?
  end
end
