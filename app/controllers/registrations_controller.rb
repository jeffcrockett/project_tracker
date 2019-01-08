class RegistrationsController < ApplicationController
    def index
        @registrations = Registration.order(:name)
    end

    def new
        @registration = Registration.new
        @projects = Project.all
    end

    def create
        @registration = Registration.new(registration_params)
        if @registration.save
            @registration = Registration.new
        end
        render "new"
    end

    def edit
        @registrations = Registration.order(:name)
        @registration = Registration.find(params[:id])
    end

    def update
        @registrations = Registration.order(:name)
        @registration = Registration.find(params[:id])
        if @registration.update_attributes(registration_params)
            render "index"
        else
            render "edit"
        end
    end

    def show
        raise "show"
    end

    private

    def registration_params
        params.require(:registration).permit(:project_id, :contact_id, :expiration, :notes)
    end
end

