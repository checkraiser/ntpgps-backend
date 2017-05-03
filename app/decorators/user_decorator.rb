module UserDecorator
  def info
    "#{name} - #{latest_update_time}</div>"
  end

  def lat
    latitude
  end

  def lng
    longitude
  end

  def icon_path
    ActionController::Base.helpers.image_url(online_status_str)
  end

  def online_status_str
    return 'online.gif' if online_status
    'offline.gif'
  end

  def latest_update_time
    update_location_at.strftime("%d/%m/%Y %H:%M")
  end

  def title
    info
  end
end

