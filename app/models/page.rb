class Page < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "content", "slug", "created_at", "updated_at"]
  end
end