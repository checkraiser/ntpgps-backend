class HistoryCheckInOutView < ApplicationRecord
  def self.refresh
    Scenic.database.refresh_materialized_view(:history_check_in_out_views, concurrently: true)
  end

  def readonly?
    true
  end
end
