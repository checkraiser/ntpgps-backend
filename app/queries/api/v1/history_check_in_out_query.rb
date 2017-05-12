class Api::V1::HistoryCheckInOutQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @name = options[:name].to_s
    @group_id = options[:group_id].to_s
    @query = SqlQuery.new("api/v1/history_check_in_out_query", name: name, group_id: group_id)
  end

  private

  def has_all_params?
    name.present? && group_id.present?
  end

  def has_only_name?
    name.present? && !group_id.present?
  end

  def has_only_grouop_name
    !name.present? && group_id.present?
  end

  attr_reader :name, :group_id
  attr_accessor :current_user, :query
end
