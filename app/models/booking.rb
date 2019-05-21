class Booking < ApplicationRecord
  belongs_to :renter, class_name: "User",
                      foreign_key: "user_id"
  belongs_to :tool

  validates :user_id, presence: true, allow_blank: false
  validates :tool_id, presence: true, allow_blank: false
  validates :status, inclusion: { in: %w[pending approved rejected] }
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
  validates :start_date, presence: true, date: { after_or_equal_to: Date.today }
end
