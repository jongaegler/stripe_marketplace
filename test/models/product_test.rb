require 'test_helper'
require 'minitest/mock'

class ProductTest < ActiveSupport::TestCase
  test '#display_price' do
    product = create(:product)

    assert_equal(product.display_price, '$1.00')
  end

  test '#purchase' do
    product = create(:product)

    mock = Minitest::Mock.new
    def mock.charge; end

    StripeService.stub :new, mock do
      product.purchase
    end

    assert_not_nil(product.reload.purchased_at)
  end
end
