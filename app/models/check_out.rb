class CheckOut < ApplicationRecord
  belongs_to :user
  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address

  validates :latitude, presence: true
  validates :longitude, presence: true
end
