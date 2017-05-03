class Location < ApplicationRecord
  belongs_to :user
  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address

  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :date, -> (from_date, to_date) { where('created_at BETWEEN ? AND ?', from_date.beginning_of_day, to_date.end_of_day) }
end
