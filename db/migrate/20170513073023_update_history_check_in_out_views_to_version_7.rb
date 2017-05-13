class UpdateHistoryCheckInOutViewsToVersion7 < ActiveRecord::Migration
  def change
    update_view :history_check_in_out_views,
      version: 7,
      revert_to_version: 6,
      materialized: true
  end
end
