class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def total_items
    cart_products.count
  end

  def total_price
    cart_products
      .includes(:product)
      .reduce(0) { |total, cart_product| total + (cart_product.qty * cart_product.product.price) }
    # Pure SQL total count, nice and fast if showing total all over the shop.
    # cart_total = self.class.where(id: id).joins(cart_products: :product).sum('COALESCE(products.price * cart_products.qty, 0.0)')
  end

  def total_price_cents
    (total * 100).to_i
  end
end
