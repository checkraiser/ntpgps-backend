class UpdateCheckOutDayViewsToVersion2 < ActiveRecord::Migration
  def change
    update_view :check_out_day_views,
      version: 2,
      revert_to_version: 1,
      materialized: true
  end
end
