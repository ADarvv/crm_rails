class Customer < ApplicationRecord
  has_one_attached :image

  validates :full_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "full_name", "phone_number", "email_address", "notes", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end
end