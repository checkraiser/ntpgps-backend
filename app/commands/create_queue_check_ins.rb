class CreateQueueCheckIns
  prepend SimpleCommand
  include ActiveModel::Model

  validates :current_user, presence: true

  def initialize(options = {})
    @check_ins = options.fetch(:check_ins, [])
    @current_user = options[:current_user]
  end

  def call
    return nil unless valid?
    return [] if check_ins.empty?
    CheckIn.transaction do
      check_ins.each do |location|
        CreateCheckIn.call(
          current_user, location[:latitude], location[:longitude], location[:percentage], location[:time]
        )
      end
    end
  end

  private

  attr_reader :current_user, :check_ins
end
