class UpdateHistoryCheckInOutViewsToVersion4 < ActiveRecord::Migration
  def change
    update_view :history_check_in_out_views,
      version: 4,
      revert_to_version: 3,
      materialized: true
  end
end
