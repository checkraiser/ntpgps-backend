class Api::V1::LateCheckInsQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @month = options[:month]
    @query = SqlQuery.new("api/v1/late_check_ins_query", month: month)
  end

  private

  attr_reader :month
  attr_accessor :current_user, :query
end
