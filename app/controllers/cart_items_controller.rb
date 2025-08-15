class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :update, :destroy]

  def index
    @cart_items = current_cart.includes(:product)
    @total = @cart_items.sum(&:total_price)
  end

  def show
    # This action is needed for the route, but we might redirect to index
    redirect_to cart_items_path
  end

  def create
    @product = Product.find(params[:product_id])
    @cart_item = current_cart.find_by(product: @product)

    if @cart_item
      @cart_item.quantity += params[:quantity].to_i
    else
      @cart_item = current_cart.build(
        product: @product,
        quantity: params[:quantity].to_i,
        session_id: session.id.to_s
      )
      @cart_item.user = current_user if user_signed_in?
    end

    if @cart_item.save
      redirect_to cart_items_path, notice: 'Item added to cart!'
    else
      redirect_to @product, alert: 'Unable to add item to cart.'
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: 'Cart updated!'
    else
      redirect_to cart_items_path, alert: 'Unable to update cart.'
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'Item removed from cart!'
  end

  private

  def set_cart_item
    @cart_item = current_cart.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end