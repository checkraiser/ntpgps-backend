class CreateCheckInLateViews < ActiveRecord::Migration
  def change
    create_view :check_in_late_views, materialized: true
  end
end
