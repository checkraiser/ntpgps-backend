class CreateCheckOutDayViews < ActiveRecord::Migration
  def change
    create_view :check_out_day_views, materialized: true
  end
end
