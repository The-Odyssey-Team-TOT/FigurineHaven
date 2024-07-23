class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :broom

  STATUS = %w[Accepted Declined Pending]
  validates :status, inclusion: { in: STATUS }
  validates :start_date, :end_date, presence: true
end
