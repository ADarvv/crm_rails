# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.available.includes(:categories, images_attachments: :blob)
    
    # Filter by category if provided
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @products.by_category(@category)
    end
    
    # Search functionality
    if params[:search].present?
      @products = @products.search_by_name(params[:search])
                           .or(@products.search_by_description(params[:search]))
    end
    
    
    @products = @products.page(params[:page]).per(12)
    
    @categories = Category.with_products
  end

  def show
    @related_products = Product.joins(:categories)
                              .where(categories: { id: @product.category_ids })
                              .where.not(id: @product.id)
                              .limit(4)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end