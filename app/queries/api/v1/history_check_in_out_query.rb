class Api::V1::HistoryCheckInOutQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @name = options[:name].to_s
    @group_name = options[:group_name].to_s
    @query = SqlQuery.new("api/v1/history_check_in_out_query", name: name, group_name: group_name)
  end

  private

  attr_reader :name, :group_name
  attr_accessor :current_user, :query
end
