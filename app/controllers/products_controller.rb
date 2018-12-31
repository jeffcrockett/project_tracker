class ProductsController < ApplicationController
  def index
    @products = Product.order(:name)
  end

  def new
    @product = Product.new
  end

  def create
    raise "create"
  end

  def edit
    @products = Product.order(:name)
    @product = Product.find(params[:id])
  end

  def update
    raise "update"
  end

  def show
    raise "show"
  end
end
