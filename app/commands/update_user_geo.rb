class UpdateUserGeo
  prepend SimpleCommand

  def initialize(user, latitude, longitude, percentage, update_location_at = Time.current)
  	@user = user
  	@latitude = latitude
  	@longitude = longitude
    @percentage = percentage
  end

  def call
    old_online_status = @user.online_status
  	@user.assign_attributes latitude: @latitude, 
                            longitude: @longitude,                             
                            online_status: !old_online_status,
                            update_location_at: update_location_at
    @user.percentage = @percentage if percentage    
    @user.save!
    Report.refresh
    @user
  rescue => e
  	errors.add :update_user_geo, e.message
  end
end
