class UserReportQuery < ApplicationQuery
  def initialize
    @query = SqlQuery.new(:user_report_query)
  end
end