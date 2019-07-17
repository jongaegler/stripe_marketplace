class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:stripe_connect]

  def self.from_stripe(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.update(
        email: auth['info']['email'],
        name: auth['info']['name'],
        password: Devise.friendly_token[0, 20],
        # stripe_key: key
      )
    end
  end
end
