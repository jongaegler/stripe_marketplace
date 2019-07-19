class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates :price, numericality: { greater_than: 50 }
  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false

  def purchase
    return if purchased_at
    StripeService.new(self).charge

    update(purchased_at: Time.now)
  end

  def display_price # should be in a presenter/helper
    Money.new(price, 'USD').format
  end
end
