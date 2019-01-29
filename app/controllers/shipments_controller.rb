class ShipmentsController < ApplicationController

  def new
    @shipment = Shipment.new
    @project = Project.find(params[:id])
    @products = Product.order(:name)
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      helpers.flash_success("Shipment successfully created.")
    else 
      helpers.flash_errors_for(@shipment)
    end
    redirect_to "/projects/#{@shipment.project_id.to_s}/edit"
    
  end

  def edit
    @shipment = Shipment.find(params[:id])
    @project = Project.find(@shipment.project_id)
    @products = Product.order(:name)
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update_attributes(shipment_params)
      helpers.flash_success("Shipment updated successfully")
    else
      helpers.flash_errors_for(@shipment)
    end
    redirect_to "/projects/#{@shipment.project_id.to_s}/edit"
  end

  def destroy
    @shipment = Shipment.find_by id:params[:id]
    @shipment.destroy()
    redirect_to "/projects/#{@shipment.project_id.to_s}/edit"
  end

  private

  def shipment_params
    params.require(:shipment).permit(:quantity, :project_id, :product_id, :date, :notes)
  end
end


