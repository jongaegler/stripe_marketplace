class WebhooksController < ApplicationController
  EVENT_TYPE = 'checkout.session.completed'

  def webhooks
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      # Invalid payload or signiture
      head 400
      return
    end

    product.purchase if event['type'] == EVENT_TYPE && session

    render json: { status: 200 }
  end

  private

  def endpoint_secret
    Rails.application.credentials.stripe[:webhook_key]
  end

  def session
    Session.find_by(uid: params['data']['object']['id'])
  end

  def product
    session.product
  end
end
