class Report
  def self.refresh
    CheckInDayView.refresh
    CheckInLateView.refresh
    CheckOutDayView.refresh
    CheckOutEarlyView.refresh
    HistoryCheckInOutView.refresh
  end
end
