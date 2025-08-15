class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def current_cart
    @current_cart ||= if user_signed_in?
      current_user.cart_items
    else
      CartItem.where(session_id: session_id_string)
    end
  end
  helper_method :current_cart
  
  def cart_item_count
    current_cart.sum(:quantity) || 0
  rescue
    0
  end
  helper_method :cart_item_count

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :city, :province, :postal_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :city, :province, :postal_code])
  end

  def session_id_string
    session.id.to_s
  end
end