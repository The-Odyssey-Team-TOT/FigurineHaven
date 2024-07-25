class CheckoutsController < ApplicationController
  def create
    @order = current_user.orders.find_by(status: 'cart')

    if @order.nil?
      render json: { error: 'No active cart found' }, status: :unprocessable_entity
      return
    end

    if @order.update(status: 'pending')
      begin
        # - session de paiement Stripe -
        session = Stripe::Checkout::Session.create(
          mode: 'payment',
          payment_method_types: ['card'],
          line_items: @order.order_items.map { |item|
            {
              price_data: {
                currency: 'usd',
                product_data: {
                  name: item.product.name,
                  description: item.product.description,
                  images: [item.product.image_url]
                },
                unit_amount: (item.unit_price * 100).to_i
              },
              quantity: item.quantity
            }
          },
          success_url: order_url(@order),
          cancel_url: order_url(@order)
        )

        @order.update(checkout_session_id: session.id)
        redirect_to new_order_payment_path(@order)
      rescue Stripe::StripeError => e
        logger.error "Stripe error: #{e.message}"
        @order.update(status: 'cart') # Rétablir le statut si l'err se produit
        render json: { error: 'Unable to create Stripe session' }, status: :internal_server_error
      end
    else
      render json: { error: 'Unable to process the order' }, status: :internal_server_error
    end
  rescue StandardError => e
    logger.error "Checkout error: #{e.message}"
    render json: { error: 'An error occurred during checkout' }, status: :internal_server_error
  end
end
