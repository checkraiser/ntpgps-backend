class ReportsController < ApplicationController
  before_action :authorize_admin!

  def details
    @users = User.not_admin.page(params[:page]).per(10)
  end

  def get_general
  	
  end

  def general
    @result = paginate(Api::V1::CheckInsQuery.new(month: params[:month], group_id: 1).render)
  end

  def detail
    @user = User.find_by(id: params[:id])
    @from_date = params[:from_date]
    @to_date = params[:to_date]
    @reports = Api::V1::DetailReportQuery.new(params).render
  end
end
