class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :ensure_cart_not_empty, only: [:new, :create]

  def index
    @orders = current_user.orders.includes(:order_items, :products)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new
    @cart_items = current_cart.includes(:product)
    @subtotal = @cart_items.sum(&:total_price)
    @tax = @subtotal * 0.13
    @total = @subtotal + @tax

    if user_signed_in?
      @order.email = current_user.email
      @order.first_name = current_user.first_name
      @order.last_name = current_user.last_name
      @order.address = current_user.address
      @order.city = current_user.city
      @order.province = current_user.province
      @order.postal_code = current_user.postal_code
    end
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?
    
    @cart_items = current_cart.includes(:product)
    @subtotal = @cart_items.sum(&:total_price)
    @tax = @subtotal * 0.13
    @total = @subtotal + @tax
    @order.total_amount = @total

    ActiveRecord::Base.transaction do
      if @order.save
        # Create order items
        @cart_items.each do |cart_item|
          @order.order_items.create!(
            product: cart_item.product,
            quantity: cart_item.quantity,
            price_at_time: cart_item.product.price
          )
        end

        # Clear the cart
        current_cart.destroy_all

        redirect_to @order, notice: 'Order placed successfully!'
      else
        render :new, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  private

  def order_params
    params.require(:order).permit(:email, :first_name, :last_name, :address, 
                                  :city, :province, :postal_code)
  end

  def ensure_cart_not_empty
    if current_cart.empty?
      redirect_to products_path, alert: 'Your cart is empty!'
    end
  end
end