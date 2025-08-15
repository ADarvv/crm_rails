class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }

  enum :status, {
    pending: 'pending',
    processing: 'processing',
    shipped: 'shipped',
    delivered: 'delivered',
    cancelled: 'cancelled'
  }

  def subtotal
    order_items.sum(&:total_price)
  end

  def tax_amount
    subtotal * 0.13
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "email", "first_name", "last_name", "address", "city", "province", "postal_code", "status", "total_amount", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "order_items", "products"]
  end
end