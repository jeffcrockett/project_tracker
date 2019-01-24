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
            helpers.flash_success("Registration successfully created.")
            @registration = Registration.new
        else 
            helpers.flash_errors_for(@registration)
        end
        @projects = helpers.unregistered_project_list
        redirect_to action: "new"
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
            redirect_to action: "index"
        else
            redirect_to action:"edit", id: params[:id]
        end
    end

    def show
        raise "show"
    end

    #getcompany", "forcompany", "expiration", and "display"
    def getcompany
        @companies = Company.all
        render 'company'
    end

    def forcompany
        @companies = Company.all 
        @company = Company.find(params[:id])
        @registrations = helpers.regs_for_company(@company.id).sort_by{|reg| reg.expiration}
        render 'company'
    end

    def expiration
        puts Registration.all.map{|r| r.expiration}
        non_nil_dates = Registration.all.find_all{|reg| reg.expiration}
        nil_dates = Registration.all.find_all{|reg| !reg.expiration}.sort_by{|reg| reg.expiration}
        nil_dates.each do |reg|
            non_nil_dates << reg
        end
        @registrations = non_nil_dates
        # @registrations = Registration.all.sort_by{|reg| reg.expiration}
        render 'display'
    end

    def display
        puts 'hello world!'
    end

    private

    def registration_params
        params.require(:registration).permit(:project_id, :contact, :expiration, :notes)
    end
end

