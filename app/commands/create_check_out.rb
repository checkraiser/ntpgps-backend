class CreateCheckOut
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage, update_location_at = Time.current.in_time_zone)
    @user = user
    @latitude = latitude
    @longitude = longitude
    @percentage = percentage
    @update_location_at = update_location_at
  end

  def call
    check_out = user.check_outs.at(update_location_at.to_date).first
    errors.add :create_check_out, 'Check Out exists' if check_out
    unless check_out
      User.transaction do
        user.update! latitude: latitude, 
                     longitude: longitude, 
                     online_status: true,
                     update_location_at: update_location_at
        check_out = user.check_outs.create!  latitude: latitude,
                                             longitude: longitude,
                                             percentage: percentage,
                                             created_at: update_location_at
        user.locations.create! latitude: latitude,
                               longitude: longitude,
                               percentage: percentage,
                               created_at: update_location_at
        Report.refresh                               
      end
    end
  rescue => e
    errors.add :create_check_out, e.message
  end

  private

  attr_accessor :check_out, :user, :latitude, :longitude, :update_location_at, :percentage
end
