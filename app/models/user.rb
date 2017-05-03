class User < ApplicationRecord
  has_secure_password
  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address
  has_many :check_ins
  has_many :check_outs
  has_many :locations
  has_many :user_groups
  has_many :groups, through: :user_groups

  validates :name, presence: true
  validates :email, presence: true

  scope :admin,   -> { where(admin: true) }
  scope :online,  -> { where(online_status: true) }
  scope :offline, -> { where(online_status: false) }
end

