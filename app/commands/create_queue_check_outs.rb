class CreateQueueCheckOuts
  prepend SimpleCommand
  include ActiveModel::Model

  validates :current_user, presence: true

  def initialize(options = {})
    @check_outs = options.fetch(:check_outs, [])
    @current_user = options[:current_user]
  end

  def call
    return nil unless valid?
    return [] if check_outs.empty?
    CheckOut.transaction do
      check_outs.each do |location|
        CreateCheckOut.call(
          current_user, location[:latitude], location[:longitude], location[:percentage], location[:time]
        )
      end
    end
  end

  private

  attr_reader :current_user, :check_outs
end
