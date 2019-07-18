class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  # polymorphic purchaser?

  def purchase
    StripeService.new(self).charge

    update(purchased_at: Time.now)
  end
end
