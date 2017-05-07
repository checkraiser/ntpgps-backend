class Api::V1::DetailReportQuery < ApplicationQuery
  def initialize(options = {})
    @current_user = options[:current_user]
    @user_id =      options[:id].to_i
    @from_date = process_from_date(options[:from_date])
    @to_date = process_to_date(options[:to_date])
    @query = SqlQuery.new('api/v1/detail_report_query', user_id: @user_id, from_date: @from_date, to_date: @to_date)
  end

  private

  attr_accessor :current_user, :query

  def process_from_date(from_date)
    Date.strptime(from_date, "%d/%m/%Y").strftime("%Y-%m-%d")
  rescue => e
    Date.current
  end

  def process_to_date(to_date)
    Date.strptime(to_date, "%d/%m/%Y").strftime("%Y-%m-%d")
  rescue => e
    Date.current
  end
end
