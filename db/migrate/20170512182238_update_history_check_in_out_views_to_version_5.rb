class UpdateHistoryCheckInOutViewsToVersion5 < ActiveRecord::Migration
  def change
    update_view :history_check_in_out_views,
      version: 5,
      revert_to_version: 4,
      materialized: true
  end
end
