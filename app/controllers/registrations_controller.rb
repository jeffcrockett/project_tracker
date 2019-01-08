class RegistrationsController < ApplicationController
    def index
        @registrations = helpers.registration_list
        puts @registrations.inspect
    end

    def new
        @registration = Registration.new
        @projects = helpers.unregistered_project_list
    end

    def create
        @registration = Registration.new(registration_params)
        if @registration.save
            @registration = Registration.new
        end
        @projects = helpers.unregistered_project_list
        render "new"
    end

    def edit
        @registrations = helpers.registration_list
        puts params[:id]
        puts params[:id].class
        @registration = Registration.find(params[:id])
        puts Registration.first.project_id
    end

    def update
        @registrations = helpers.registration_list
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
        params.require(:registration).permit(:project_id, :contact, :expiration, :notes)
    end
end

