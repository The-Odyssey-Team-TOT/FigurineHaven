class CartsController < ApplicationController
  before_action :set_order, only: [:add_item, :show, :remove_item]

  def add_item
    product = Product.find(params[:product_id])
    @cart_item = @order.order_items.find_or_initialize_by(product: product)

    # Si l'article est nouvellement ajouté, fixez la quantité à 1
    if @cart_item.new_record?
      @cart_item.unit_price = product.price
      @cart_item.quantity = 1
    else
      @cart_item.quantity += 1
    end

    if @cart_item.save
      redirect_to cart_path, notice: 'Product was successfully added to your cart.'
    else
      redirect_to product_path(product), alert: 'There was a problem adding the product to your cart.'
    end
  end

  def show
    @order_items = @order.order_items
  end

  def remove_item
    @cart_item = @order.order_items.find_by(product_id: params[:product_id])
    if @cart_item
      @cart_item.destroy
      notice = 'Product was successfully removed from your cart.'
    else
      notice = 'Product not found in your cart.'
    end
    redirect_to cart_path, notice: notice
  end

  private

  def set_order
    @order = current_user.orders.find_or_create_by(status: 'cart')
  end
end
