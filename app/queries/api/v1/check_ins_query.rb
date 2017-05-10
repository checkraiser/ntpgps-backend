class Api::V1::CheckInsQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @month = options[:month].to_i
    @query = SqlQuery.new("api/v1/check_ins_query", month: month)
  end

  private

  attr_reader :group_id, :month
  attr_accessor :current_user, :query
end
