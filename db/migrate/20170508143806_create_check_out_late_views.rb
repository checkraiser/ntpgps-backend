class CreateCheckOutLateViews < ActiveRecord::Migration
  def change
    create_view :check_out_late_views, materialized: true
  end
end
