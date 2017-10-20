class ApplicationController < ActionController::Base
  include CartHelper
  protect_from_forgery with: :exception

  before_action :set_cart

  def set_cart
    @cart = current_cart
  end
end
