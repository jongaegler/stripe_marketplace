class StripeService
  attr_accessor :product, :user

  def initialize(product, user)
    @product = product
  end

  def checkout
    url = "http://localhost:3000/products/#{product.id}/"
    stripe_session = Stripe::Checkout::Session.create(
      success_url: url + 'purchase_success',
      payment_method_types: ['card'],
      line_items: [item],
      cancel_url: url
    )
    Session.create(uid: session['id'], product: product)

    stripe_session
  end

  def charge
    price = product.price
    Stripe::Charge.create(
      {
        amount: price,
        currency: 'usd',
        source: 'tok_visa',
        application_fee_amount: price * 0.1,
      },
      stripe_account: account_id,
    )
  end

  private

  def item
    {
      quantity: 1,
      amount: product.price + 100, #temp to make stripe pass
      name: product.title,
      currency: 'usd',
    }
  end

end
