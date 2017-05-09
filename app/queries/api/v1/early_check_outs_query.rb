class Api::V1::EarlyCheckOutsQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @month = options[:month]
    @query = SqlQuery.new("api/v1/early_check_outs_query", month: month)
  end

  private

  attr_reader :month
  attr_accessor :current_user, :query
end
