class UpdateHistoryCheckInOutViewsToVersion3 < ActiveRecord::Migration
  def change
    update_view :history_check_in_out_views,
      version: 3,
      revert_to_version: 2,
      materialized: true
  end
end
