require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test '#display_price' do
    product = create(:product)

    assert_equal(product.display_price, '$1.00')
  end

  test '#purchase' do
    product = create(:product)
    product.purchase
  end
end
