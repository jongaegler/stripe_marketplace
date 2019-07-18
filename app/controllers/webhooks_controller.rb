class WebhooksController < ApplicationController
  def webhooks
    endpoint_secret = Rails.application.credentials.stripe[:webhook_key]
    payload = request.body.read

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      # Invalid payload or signiture
      status 400
      return
    end

    if event['type'] == 'checkout.session.completed'
      # purchase successful
      render json: { status: 200}
    else
      render json: { status: 400}
    end
  end
end
