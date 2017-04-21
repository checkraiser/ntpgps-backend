class ApplicationController < ActionController::Base
  include Negotiation
  include Protection
  include Authentication
  include Authorization
  include Rendering
end
