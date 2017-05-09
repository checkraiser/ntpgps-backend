class Report
  def self.refresh
    CheckInDayView.refresh
    CheckInLateView.refresh
    CheckOutDayView.refresh
    CheckOutEarlyView.refresh
  end
end
