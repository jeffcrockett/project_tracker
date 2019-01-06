class ProductsController < ApplicationController
  def index
    @products = Product.order(:name)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      @product = Product.new
    end
    render "new"
  end

  def edit
    @products = Product.order(:name)
    @product = Product.find(params[:id])
  end

  def update
    @products = Product.order(:name)
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      render "index"
    else
      render "edit"
    end
  end

  def markfordeath
    @products = Product.order(:name)
    @product = Product.new
  end

  def destroy
    @products = Product.order(:name)
    @product = Product.find(params[:id])
    if Shipment.where(product_id: @product.id).length > 0
      @product.errors[:base] << "Can't delete " + @product.name + " because at least one shipment refers to it"
    else
      @product.destroy()
      @product = Product.new
    end
    render "markfordeath"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :cogs)
  end
end