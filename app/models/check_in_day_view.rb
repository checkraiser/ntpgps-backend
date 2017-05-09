class CheckInDayView < ApplicationRecord
  def self.refresh
    Scenic.database.refresh_materialized_view(:check_in_day_views, concurrently: true)
  end

  def readonly?
    true
  end
end
