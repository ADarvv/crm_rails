class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price_at_time, presence: true, numericality: { greater_than: 0 }

  def total_price
    price_at_time * quantity
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "order_id", "product_id", "quantity", "price_at_time", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order", "product"]
  end
end