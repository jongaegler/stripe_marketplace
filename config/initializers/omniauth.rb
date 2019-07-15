Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, Rails.application.credentials.stripe[:client_id], Rails.application.credentials.stripe[:secret_key]
end
