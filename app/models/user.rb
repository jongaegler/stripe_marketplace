class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :omniauthable, :omniauth_providers => [:stripe_connect],
         :registerable, :recoverable, :rememberable, :validatable
end
