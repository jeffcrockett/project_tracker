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
    @projects = helpers.project_list
    @project = Project.find(params[:id])
    @project.destroy()
    @project = Project.new
    render "markfordeath"
  end

  private

  def project_params
    params.require(:project).permit(:name, :confidence, :rep, :notes, :application, :distributor_id)
  end

end
