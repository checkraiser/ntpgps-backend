module Rendering
  extend ActiveSupport::Concern

  included do 
  	helper_method :active_class
  end

  private

  def active_class(route)
  	request.env['PATH_INFO'] == route ? "active" : ""
  end
end