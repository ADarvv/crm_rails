class HomeController < ApplicationController
  def index
    @featured_products = Product.available.limit(8).includes(images_attachments: :blob)
    @categories = Category.with_products.limit(6)
  end
end