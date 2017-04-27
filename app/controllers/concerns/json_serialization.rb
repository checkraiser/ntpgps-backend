module JsonSerialization
  extend ActiveSupport::Concern

  def serialize(obj, options = {})
  	obj.as_json(options)
  end
end