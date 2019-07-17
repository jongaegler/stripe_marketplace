class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:stripe_connect]

  def self.from_stripe(params)
    user = User.find_or_create_by(uid: params['uid'])
    return user unless user.persisted?
    user.update(

      email: params['info']['email']
    )
  end

  def failure
    redirect_to root_path
  end
end
