class CreateCheckInDayViews < ActiveRecord::Migration
  def change
    create_view :check_in_day_views, materialized: true
  end
end
