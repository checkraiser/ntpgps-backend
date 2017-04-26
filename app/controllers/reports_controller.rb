class ReportsController < ApplicationController
  before_action :authorize_admin!

  def export
  	select1 = "users.id as uid, check_ins.address as ci_address, check_ins.created_at::date as ci_date, to_char(check_ins.created_at, 'HH24:MI') as ci_time"
  	select2 = "check_outs.address as co_address, check_outs.created_at::date as co_date, to_char(check_outs.created_at, 'HH24:MI') as co_time"
  	@reports = User.joins(:check_ins).select(select1).joins(:check_outs).select(select2)
  end
end
