class ApplicationController < ActionController::Base
  include Negotiation
  include Protection
  include Authentication
  include Authorization
end
