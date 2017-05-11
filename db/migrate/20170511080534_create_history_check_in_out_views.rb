class CreateHistoryCheckInOutViews < ActiveRecord::Migration
  def change
    create_view :history_check_in_out_views, materialized: true
  end
end
