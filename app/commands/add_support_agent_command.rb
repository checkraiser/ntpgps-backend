class AddSupportAgentCommand
  prepend SimpleCommand
  include ActiveModel::Model

  
  validates :email , presence: true

  validates :first_name , presence: true

  validates :last_name , presence: true

  validates :password , presence: true

  validates :password_confirmation , presence: true

  def initialize(current_user:, email:, first_name:, last_name:, password:, password_confirmation:)
    @current_user = current_user
    @email = email
		@first_name = first_name
		@last_name = last_name
		@password = password
		@password_confirmation = password_confirmation
  end

  def call
    return nil unless valid?
    add_support_agent
  end
  

  private

  def add_support_agent
    
  rescue => e
    errors.add :add_support_agent, e.message
    nil
  end

  attr_reader :current_user, :email, :first_name, :last_name, :password, :password_confirmation
end
