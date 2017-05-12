class Api::V1::HistoryCheckInOutQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @query = options[:query].to_s
    @group_id = options[:group_id].to_s
    @query = SqlQuery.new("api/v1/history_check_in_out_query", 
                          query: query, group_id: group_id,
                          has_all_params: has_all_params?, has_only_query: has_only_query?, 
                          has_only_group_id: has_only_group_id?)
  end

  private

  def has_all_params?
    query.present? && group_id.present?
  end

  def has_only_query?
    query.present? && !group_id.present?
  end

  def has_only_group_id?
    !query.present? && group_id.present?
  end

  attr_reader :query, :group_id
  attr_accessor :current_user, :query
end
