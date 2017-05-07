class TotalTimeQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @group_id = options[:group_id]
    @month = options[:month]
    @query = SqlQuery.new(:total_time_query, group_id: group_id, month: month)
  end

  private

  attr_reader :group_id, :month
  attr_accessor :current_user, :query
end
