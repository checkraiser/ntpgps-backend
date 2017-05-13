class UpdateHistoryCheckInOutViewsToVersion6 < ActiveRecord::Migration
  def change
    update_view :history_check_in_out_views,
      version: 6,
      revert_to_version: 5,
      materialized: true
  end
end
