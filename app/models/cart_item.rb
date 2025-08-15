class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :session_id, presence: true, unless: :user_id?

  def total_price
    product.price * quantity
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "product_id", "user_id", "session_id", "quantity", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["product", "user"]
  end
end