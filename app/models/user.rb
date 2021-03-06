class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:stripe_connect]

  has_many :products

  def self.from_stripe(auth)
    where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
      user.email = auth['info']['email']
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
