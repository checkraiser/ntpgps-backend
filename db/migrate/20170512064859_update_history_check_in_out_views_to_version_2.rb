class UpdateHistoryCheckInOutViewsToVersion2 < ActiveRecord::Migration
  def change
    update_view :history_check_in_out_views,
      version: 2,
      revert_to_version: 1,
      materialized: true
  end
end
