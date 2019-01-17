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
    redirect_to action: "new"
  end

  def edit
    @projects = helpers.project_list
    @project = Project.find(params[:id])
    @shipments = helpers.shipments_for_project(params[:id])
  end

  def getshift
    @project = Project.find(params[:id])
    # render 'getshift'
  end

  def doshift
    @project = Project.find(params[:id])
    @projects = helpers.project_list
    @shipments = helpers.shipments_for_project(params[:id])
    @shipments.each do |s|
        s.update_attributes(date: s.date + params[:days].to_i.days + params[:weeks].to_i.weeks + params[:months].to_i.months)
    end
    redirect_to action:"edit"
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
        @shipments = Shipment.select{|s| Date.strptime(params[:user][:start_date], '%m/%d/%Y') <= s.date && s.date <= Date.strptime(params[:user][:end_date], '%m/%d/%Y') && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
        @revenues = @shipments.map{|s| (s.product.price - s.project.distributor.discount) * s.quantity}
        @full_shipments = @shipments.map{|s| [helpers.full_project_name(s.project), s]}
        redirect_to action:"review"
        return 
    end
    @projects = helpers.project_list
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to action:"index"
    else
      redirect_to action:"edit", id: params[:id]
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
    redirect_to action:"markfordeath"
  end

  def review
    # render 'review'
  end

  def revenue_margin
    if params[:commit]
      @shipments = Shipment.select{|s| Date.strptime(params[:user][:start_date], '%Y-%m-%d') <= s.date && s.date <= Date.strptime(params[:user][:end_date], '%Y-%m-%d') && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
      @results_hash = {}
      @revenues_and_margins = @shipments.map{|s| [s.product.name, helpers.revenue_from(s).to_f, helpers.margin_from(s).to_f]}
      @revenues_and_margins.each do |x| 
        @results_hash[x[0]] = {:revenue => [], :margin => []}
      end
      @revenues_and_margins.each do |x|
        @results_hash[x[0]][:revenue] << x[1]
        @results_hash[x[0]][:margin] << x[2]
      end
      @results_hash.keys.each do |key|
        @results_hash[key][:total_revenue] = helpers.sum_of(@results_hash[key][:revenue])
        @results_hash[key][:total_margin] = helpers.sum_of(@results_hash[key][:margin])
      end
    # render 'revenue-margin'
    end
  end

  def cash_flow
    if params[:commit]
      @shipments = Shipment.select{|s| Date.strptime(params[:user][:start_date], '%Y-%m-%d') <= s.date && s.date <= Date.strptime(params[:user][:end_date], '%Y-%m-%d') && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
      @cash_flow = helpers.cash_flow_for(@shipments)
    # render 'cash-flow'
    end
  end

  def filter
    @start_date = params[:user][:start_date]
    @end_date = params[:user][:end_date]
    @min_confidence = params[:user][:min_confidence]
    @max_confidence = params[:user][:max_confidence]
    puts '@start_date is ', params[:user][:start_date]
    puts '@end_date is ', params[:user][:end_date]
    @shipments = Shipment.select{|s| Date.strptime(params[:user][:start_date], '%Y-%m-%d') <= s.date && s.date <= Date.strptime(params[:user][:end_date], '%Y-%m-%d') && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
    @results_hash = {}
    @revenues_and_margins = @shipments.map{|s| [s.product.name, helpers.revenue_from(s).to_f, helpers.margin_from(s).to_f]}
    @revenues_and_margins.each do |x| 
      @results_hash[x[0]] = {:revenue => [], :margin => []}
    end
    @revenues_and_margins.each do |x|
      @results_hash[x[0]][:revenue] << x[1]
      @results_hash[x[0]][:margin] << x[2]
    end
    @results_hash.keys.each do |key|
      @results_hash[key][:total_revenue] = helpers.sum_of(@results_hash[key][:revenue])
      @results_hash[key][:total_margin] = helpers.sum_of(@results_hash[key][:margin])
    end
    @cash_flow = helpers.cash_flow_for(@shipments)
    @full_shipments = @shipments.map{|s| [helpers.full_project_name(s.project), s]}
    render 'review'
  end

  private

  def project_params
    params.require(:project).permit(:name, :confidence, :rep, :notes, :application, :distributor_id)
  end

end
