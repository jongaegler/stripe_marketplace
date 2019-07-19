class StripeService
  attr_accessor :product

  def initialize(product)
    @product = product
  end

  def checkout
    url = "https://stripe-marketplace.herokuapp.com/products/#{product.id}/"
    stripe_session = Stripe::Checkout::Session.create(
      success_url: url + 'purchase_success',
      payment_method_types: ['card'],
      line_items: [item],
      cancel_url: url
    )
    Session.create(uid: stripe_session['id'], product: product)

    stripe_session
  end

  def charge
    price = product.price
    Stripe::Charge.create(
      {
        amount: price,
        currency: 'usd',
        source: 'tok_visa',
        application_fee_amount: (price * 0.1).to_i
      },
      stripe_account: product.user.uid
    )
  end

  private

  def item
    {
      quantity: 1,
      amount: product.price,
      name: product.title,
      currency: 'usd'
    }
  end
end
