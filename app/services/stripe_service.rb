class StripeService

  def charge
    price = 1000
    Stripe::Charge.create(
      {
        amount: price,
        currency: 'usd',
        source: 'tok_visa',
        application_fee_amount: price * 0.1,
      },
      stripe_account: "{{CONNECTED_STRIPE_ACCOUNT_ID}}"
    )
  end

end
