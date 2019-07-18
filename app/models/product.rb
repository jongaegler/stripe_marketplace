class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  def purchase
    StripeService.new(self).charge
  end
end
