class CreateTimeOfDayViews < ActiveRecord::Migration
  def change
    create_view :time_of_day_views, materialized: true
  end
end
