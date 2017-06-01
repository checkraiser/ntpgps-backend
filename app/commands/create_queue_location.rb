class CreateQueueLocation
  prepend SimpleCommand
  include ActiveModel::Model

  validates :current_user, presence: true

  def initialize(options = {})
    @locations = options.fetch(:locations, [])
    @current_user = options[:current_user]
  end

  def call
    return nil unless valid?
    return [] if locations.empty?
    Location.transaction do
      locations.each do |location|
        CreateLocation.call(
          current_user, location[:latitude], location[:longitude], location[:percentage], location[:time]
        )
      end
    end
  end

  private

  attr_reader :current_user, :locations
end
