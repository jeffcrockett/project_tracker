class ProjectsController < ApplicationController

  def index
    @projects = Project.order(:name)
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
    @projects = Project.order(:name)
    @project = Project.find(params[:id])
  end

  def update
    @projects = Project.order(:name)
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      render "index"
    else
      render "edit"
    end
  end

  def markfordeath
    @projects = Project.order(:name)
    @project = Project.new
  end

  def destroy
    @projects = Project.order(:name)
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
