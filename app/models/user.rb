class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def cart_items_for_session(session_id)
    cart_items.where(session_id: session_id)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "first_name", "last_name", "address", "city", "province", "postal_code", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["cart_items", "orders"]
  end
end