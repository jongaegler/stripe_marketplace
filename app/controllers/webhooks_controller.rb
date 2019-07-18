class WebhooksController < ApplicationController
  def webhooks
    endpoint_secret = Rails.application.credentials.stripe[:webhook_key]
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      # Invalid payload or signiture
      status 400
      return
    end

    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']

      product.purchase
      render json: { status: 200}
    else
      render json: { status: 400}
    end
  end

  private

  def product
    Session.find_by(uid: params['data']['object']['id']).product
  end
end
