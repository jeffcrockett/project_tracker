class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.order(:date)
  end

  def new
    @shipment = Shipment.new
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      @shipment = Shipment.new
    end
    render "new"
  end

  def edit
    @shipments = Shipment.order(:date)
    @shipment = Shipment.find(params[:id])
  end

  def update
    @shipments = Shipment.order(:date)
    @shipment = Shipment.find(params[:id])
    if @shipment.update_attributes(shipment_params)
      render "index"
    else
      render "edit"
    end
  end

  def markfordeath
    @shipments = Shipment.order(:date)
    @shipment = Shipment.new
  end

  def destroy
    @shipments = Shipment.order(:date)
    @shipment = Shipment.find_by id:params[:id]
    if @shipment
      @shipment.destroy()
      @shipment = Shipment.new
    end
    render "markfordeath"
  end

  private

  def shipment_params
    params.require(:shipment).permit(:quantity, :cable_length, :price, :date, :notes)
  end
end


