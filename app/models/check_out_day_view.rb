class CheckOutDayView < ApplicationRecord
  def self.refresh
    Scenic.database.refresh_materialized_view(:check_out_day_views, concurrently: true)
  end

  def readonly?
    true
  end
end
