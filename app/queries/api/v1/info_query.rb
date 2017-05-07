class Api::V1::InfoQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @query = SqlQuery.new('api/v1/info_query')
  end

  private

  attr_accessor :current_user, :query
end
