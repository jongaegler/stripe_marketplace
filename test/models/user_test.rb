require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#through_stripe' do
    # Taken from https://github.com/isaacsanders/omniauth-stripe-connect docs
    stripe_response = {
      'provider' => 'stripe_connect',
      'uid' => '<STRIPE_USER_ID>',
      'info' => {
        'email' => 'email@example.com',
        'name' => 'Name',
        'nickname' => 'Nickname',
        'scope' => 'read_write', # or "read_only"
        'livemode' => false,
        'stripe_publishable_key' => '<STRIPE_PUBLISHABLE_KEY>'
      },
      'credentials' => {
        'token' => '<STRIPE_ACCESS_TOKEN>',
        'refresh_token' => '<STRIPE_REFRESH_TOKEN>',
        'expires' => false
      },
      'extra' => {
        'raw_info' => {
          'token_type' => 'bearer',
          'stripe_user_id' => '<STRIPE_USER_ID>',
          'scope' => 'read_only',
          'stripe_publishable_key' => '<STRIPE_PUBLISHABLE_KEY>',
          'livemode' => false
        },
        'extra_info' => {
          'business_logo' => 'https://stripe.com/business_logo.png',
          'business_name' => 'Business Name',
          'business_url' => 'example.com',
          'charges_enabled' => true,
          'country' => 'US',
          'default_currency' => 'eur',
          'details_submitted' => true,
          'display_name' => 'Business Name',
          'email' => 'email@example.com',
          'id' => '<STRIPE_USER_ID>',
          'managed' => false,
          'object' => 'account',
          'statement_descriptor' => 'EXAMPLE.COM',
          'support_email' => 'support@example.com',
          'support_phone' => '123456789',
          'timezone' => 'Europe/Berlin',
          'transfers_enabled' => true
        }
      }
    }

    user = User.from_stripe(stripe_response)
    assert_equal(user.email, 'email@example.com')
    assert_equal(user.provider, 'stripe_connect')
    assert_not_nil(user.uid)
  end
end
