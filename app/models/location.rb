class Location < ApplicationRecord
  belongs_to :user
  reverse_geocoded_by :latitude, :longitude
  after_validation :fetch_address

  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :date, -> (date) { where('created_at BETWEEN ? AND ?', date.beginning_of_day, date.end_of_day) }
end
