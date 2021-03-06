class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy checkout purchase_success]

  def index
    @products = Product.where(purchased_at: nil)
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkout
    @session = StripeService.new(@product).checkout
  end

  def purchase_success
    session = StripeService.new(@product).completed_checkout
    return unless session
    @payment_info = session['payment_method_details']['card']
    @email = session['billing_details']['email']
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id] || params[:product_id])
  end

  def product_params
    params.require(:product).permit(%i[title price description image])
  end
end
