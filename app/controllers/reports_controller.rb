class ReportsController < ApplicationController
  before_action :authorize_admin!

  def details
    @users = User.not_admin.page(params[:page]).per(10)
  end

  def get_general
  	
  end

  def general
    @check_ins = Api::V1::CheckInsQuery.new(month: params[:month]).render.group_by { |x| x[:group_name] }
    @check_outs = Api::V1::CheckOutsQuery.new(month: params[:month]).render.group_by { |x| x[:group_name] }
    @late_check_ins = Api::V1::LateCheckInsQuery.new(month: params[:month]).render.group_by { |x| x[:group_name] }
    @early_check_outs = Api::V1::EarlyCheckOutsQuery.new(month: params[:month]).render.group_by { |x| x[:group_name] }
    @time_of_day = Api::V1::TimeOfDayQuery.new(month: params[:month]).render.group_by { |x| x[:group_name] }
    res = {}
    Group.pluck(:name).each do |group_name|
      gs = group_name
      res[gs] ||= {}
      if @check_ins && @check_ins[gs]
        @check_ins[gs].each do |v|
          res[gs][:check_in] ||= []
          res[gs][:check_in] << v
        end
      end
      if @check_outs && @check_outs[gs]
        @check_outs[gs].each do |v|
          res[gs][:check_out] ||= []
          res[gs][:check_out] << v
        end
      end
      if @late_check_ins && @late_check_ins[gs]
        @late_check_ins[gs].each do |v|
          res[gs][:late_check_in] ||= []
          res[gs][:late_check_in] << v
        end
      end
      if @early_check_outs && @early_check_outs[gs]
        @early_check_outs[gs].each do |v|
          res[gs][:early_check_out] ||= []
          res[gs][:early_check_out] << v
        end
      end
      if @time_of_day && @time_of_day[gs]
        @time_of_day[gs].each do |v|
          res[gs][:time_of_day] ||= []
          res[gs][:time_of_day] << v
        end
      end
    end
    @result = res
  end

  def detail
    @user = User.find_by(id: params[:id])
    @from_date = params[:from_date]
    @to_date = params[:to_date]
    @reports = Api::V1::DetailReportQuery.new(params).render
  end
end
