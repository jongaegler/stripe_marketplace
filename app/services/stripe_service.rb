class StripeService
  attr_accessor :product

  def initialize(product)
    @product = product
  end

  def checkout
    url = "http://localhost:3000/products/#{product.id}/"
    Stripe::Checkout::Session.create(
      success_url: url + 'purchase',
      payment_method_types: ['card'],
      line_items: [{
        quantity: 1,
        amount: product.price + 100, #temp to make stripe pass
        name: product.title,
        currency: 'usd',
      }],
      cancel_url: url
    )
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

end
