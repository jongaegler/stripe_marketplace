class StripeService

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
