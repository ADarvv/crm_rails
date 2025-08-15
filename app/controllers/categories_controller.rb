class CategoriesController < ApplicationController
  def index
    @categories = Category.with_products.includes(:products)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.available.includes(images_attachments: :blob)
  end
end