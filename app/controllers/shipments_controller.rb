class ShipmentsController < ApplicationController
  def index
    @shipments = helpers.shipment_list
  end

  def new
    @shipment = Shipment.new
    @projects = helpers.project_list
    @products = Product.order(:name)
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      helpers.flash_success("Shipment successfully created.")
      @project = @shipment.project
      @shipments = helpers.shipments_for_project(@shipment.project_id)  
    #   @shipment = Shipment.new
    else 
      helpers.flash_errors_for(@shipment)
    end
    # @projects = helpers.project_list
    @projects = helpers.project_list
    @products = Product.order(:name)

    render "projects/edit"
    
  end

  def edit
    @shipments = helpers.shipment_list
    @shipment = Shipment.find(params[:id])
  end

  def update
    @shipments = helpers.shipment_list
    @shipment = Shipment.find(params[:id])
    if @shipment.update_attributes(shipment_params)
      helpers.flash_success("Shipment updated successfully")
      @projects = helpers.project_list
      @project = @shipment.project
      @shipments = helpers.shipments_for_project(@shipment.project_id)  
      render "projects/edit"
    else
      helpers.flash_errors_for(@shipment)
      render "edit"
    end
  end

  def markfordeath
    @shipments = helpers.shipment_list
    @shipment = Shipment.new
  end

  def destroy
    @shipment = Shipment.find_by id:params[:id]
    @projects = helpers.project_list
    @project = @shipment.project
    @shipments = helpers.shipments_for_project(@shipment.project_id)  
    if @shipment
      @shipment.destroy()
      helpers.flash_success("Shipment successfully deleted")
      @shipment = Shipment.new
    end
    # @shipments = helpers.shipment_list
    render "projects/edit"
  end

  private

  def shipment_params
    params.require(:shipment).permit(:quantity, :project_id, :product_id, :date, :notes)
  end
end


