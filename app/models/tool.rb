class Tool < ApplicationRecord
  belong_to :user
  has_many :bookings
  validates :name, presence: true
  validates :description, presence: true
  validates :price_per_day, presence: true
  validates :category, presence: true
  validates :price_per_day, numericality: { greater_than_or_equal_to: 0 }
end
