class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }


  def calculate_total_price
    self.total_price = order_items.sum('unit_price * quantity')
  end
end
