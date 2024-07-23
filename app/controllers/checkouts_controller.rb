class CheckoutsController < ApplicationController
  def create
    @order = current_user.orders # Assurez-vous que cette méthode est correcte et fonctionne
    @order.update(status: 'pending')
    raise
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: @order.order_items.map { |item|
        {
          name: item.product.name,
          description: item.product.description,
          amount: (item.unit_price * 100).to_i, # montant en cents
          currency: 'usd',
          quantity: item.quantity,
        }
      },
      success_url: root_url,
      cancel_url: root_url,
    )

    respond_to do |format|
      format.json { render json: { sessionId: session.id } }
    end
  end
end
