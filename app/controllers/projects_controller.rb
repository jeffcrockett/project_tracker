class ProjectsController < ApplicationController

  def index
    @projects = helpers.project_list
  end

  def new
    @distributors = Distributor.all
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project = Project.new
    end
    render "new"
  end

  def edit
    @projects = helpers.project_list
    @project = Project.find(params[:id])
    @shipments = helpers.shipments_for_project(params[:id])
  end

  def getshift
    @project = Project.find(params[:id])
    render 'getshift'
  end

  def doshift
    @project = Project.find(params[:id])
    @projects = helpers.project_list
    @shipments = helpers.shipments_for_project(params[:id])
    @shipments.each do |s|
        s.update_attributes(date: s.date + params[:days].to_i.days + params[:weeks].to_i.weeks + params[:months].to_i.months)
    end
    render "edit"
  end

  def update
    if params[:id] == 'filter'
        # filter()
        @start_date = params[:user][:start_date]
        @end_date = params[:user][:end_date]
        @min_confidence = params[:user][:min_confidence]
        @max_confidence = params[:user][:max_confidence]
        puts 'Start date is ', Date.parse(params[:user][:start_date])
        puts 's.date is '
        @shipments = Shipment.select{|s| Date.parse(params[:user][:start_date]) < s.date && s.date < Date.parse(params[:user][:end_date]) && params[:user][:min_confidence].to_i < s.project.confidence && s.project.confidence < params[:user][:max_confidence].to_i}
        @full_shipments = @shipments.map{|s| [helpers.full_project_name(s.project), s]}
        render 'review'
        return 
    end
    @projects = helpers.project_list
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      render "index"
    else
      render "edit"
    end
  end

  def markfordeath
    @projects = helpers.project_list
    @project = Project.new
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy()
    @projects = helpers.project_list
    @project = Project.new
    render "markfordeath"
  end

  def review
    render 'review'
  end

  def revenue_margin
    render 'revenue-margin'
  end

  def cash_flow
    render 'cash-flow'
  end

  def filter
    puts 'filtering...'
  end

  private

  def project_params
    params.require(:project).permit(:name, :confidence, :rep, :notes, :application, :distributor_id)
  end

end
