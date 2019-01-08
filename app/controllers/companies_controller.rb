class CompaniesController < ApplicationController
  def index
    @companies = Company.order(:name)
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      @company = Company.new
    end
    render "new"
  end

  def edit
    @companies = Company.order(:name)
    @company = Company.find(params[:id])
  end

  def update
    @companies = Company.order(:name)
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      render "index"
    else
      render "edit"
    end
  end

  def markfordeath
    @companies = Company.order(:name)
    @company = Company.new
  end

  def destroy
    @companies = Company.order(:name)
    @company = Company.find_by id:params[:id]
    if @company
      @company.destroy()
      @company = Company.new
    end
    render "markfordeath"
  end

  private
  def company_params 
    params.require(:company).permit(:name)
  end
end
