class InfoQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @query = SqlQuery.new(:info_query)
  end

  private

  attr_accessor :current_user, :query
end
