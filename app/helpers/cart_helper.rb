module CartHelper
  def current_cart
    if !session.has_key? :cart_id
      @cart = nil
      return nil
    end

    cart = Cart.includes(:cart_products, :products).find_by_id(session[:cart_id]) rescue nil
    if cart == nil
      # Dodgy session :cart_id so remove and mosey on.
      session.delete :cart_id
      return nil
    end

    return cart
  end
end
