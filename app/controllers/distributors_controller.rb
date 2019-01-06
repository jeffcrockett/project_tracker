class DistributorsController < ApplicationController
    def index
        @distributors = Distributor.order(:name)
    end

    def new
        @distributor = Distributor.new
    end

    def create
        @distributor = Distributor.new(distributor_params)
        if @distributor.save
            @distributor = Distributor.new
        end
        render "new"
    end

    def edit
        @distributors = Distributor.order(:name)
        @distributor = Distributor.find(params[:id])
    end

    def update
        @distributors = Distributor.order(:name)
        @distributor = Distributor.find(params[:id])
        if @distributor.update_attributes(distributor_params)
            render "index"
        else
            render "edit"
        end
    end

    def show
        raise "show"
    end

    private

    def distributor_params
        params.require(:distributor).permit(:name, :discount, :notes)
    end
end


