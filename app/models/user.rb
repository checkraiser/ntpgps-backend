class User < ApplicationRecord
  has_secure_password
  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address
  has_many :check_ins
  has_many :check_outs
  has_many :locations

  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true

  scope :admin, -> { where(admin: true) }
end

