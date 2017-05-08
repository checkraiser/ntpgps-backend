class CheckIn < ApplicationRecord
  belongs_to :user
  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address

  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :at, -> { |date| where("date_trunc('day', created_at) = ?", date) }
end
