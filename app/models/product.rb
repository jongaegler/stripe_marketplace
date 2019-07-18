class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  def purchase
    StripeService.new.charge(price, user.account_id)
  end
end
