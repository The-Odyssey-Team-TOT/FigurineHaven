class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :unit_price, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
