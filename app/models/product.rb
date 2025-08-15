class Product < ApplicationRecord
  has_many_attached :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where('stock_quantity > 0') }
  scope :by_category, ->(category) { joins(:categories).where(categories: { id: category.id }) }
  scope :search_by_name, ->(query) { where('name ILIKE ?', "%#{query}%") }
  scope :search_by_description, ->(query) { where('description ILIKE ?', "%#{query}%") }

  def in_stock?
    stock_quantity > 0
  end

  def main_image
    images.attached? ? images.first : nil
  end

  def formatted_price
    "$#{price.to_f.round(2)}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "stock_quantity", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "product_categories", "images_attachments", "images_blobs"]
  end
end