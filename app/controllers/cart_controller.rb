class CartController < ApplicationController
  def show
  end

  def add_product
    cart = current_cart_or_new
    product = Product.find(params[:product_id])
    existing_line_item = CartProduct.find_by(product: product, cart: cart) rescue nil

    if existing_line_item
      existing_line_item.qty = existing_line_item.qty + params[:qty].to_i
      existing_line_item.save
      redirect_to products_path, notice: "Added #{params[:qty]} x #{product.name} to cart"
      return
    end

    if CartProduct.create!(product: product, cart: cart, qty: params[:qty].to_i)
      redirect_to products_path, notice: "Added #{params[:qty]} x #{product.name} to cart"
    else
      redirect_to products_path, notice: "Failed to add to cart"
    end
  end

  def remove_product
    cart_product = CartProduct.includes(:product).find_by_id(params[:cart_product_id])
    product = cart_product.product
    cart_product.delete
    redirect_to cart_path, notice: "Removed #{cart_product.qty} x #{product.name} from cart"
  end

  private

  def current_cart_or_new
    cart = current_cart
    return cart if !cart.nil?

    # Create new cart and set the id in the session hash
    new_cart = Cart.create
    session[:cart_id] = new_cart.id
    return new_cart
  end
end

Cart.joins(cart_products: :product).sum('COALESCE(products.price * cart_products.qty, 0.0)')
