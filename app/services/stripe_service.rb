class StripeService

  def checkout(product)
    Stripe::Checkout::Session.create(
      success_url: 'https://example.com/success',
      payment_method_types: ['card'],
      line_items: product,
      cancel_url: 'https://example.com/cancel'
    )
  end

  def charge(price, account_id)
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
