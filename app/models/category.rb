class Category < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_one_attached :image

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 50 }
  validates :description, length: { maximum: 500 }

  scope :with_products, -> { joins(:products).distinct }

  def product_count
    products.count
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["products", "product_categories", "image_attachment", "image_blob"]
  end
end