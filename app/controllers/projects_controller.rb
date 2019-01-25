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
    if params[:commit]
      puts 'params[:user][:start_date] is', params[:user][:start_date]
      puts 'params[:user][:end_date] is', params[:user][:end_date]
      
      current_user.update_attributes(user_params)
      @start_date = Date.strptime(params[:user][:start_date], '%Y-%m-%d')
      @end_date = Date.strptime(params[:user][:end_date], '%Y-%m-%d')
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
      @full_shipments = @shipments.map{|s| [helpers.full_project_name(s.project), s]}
    end
  end

  def revenue_margin
    if params[:commit]
      @shipments = Shipment.select{|s| Date.strptime(params[:user][:start_date], '%Y-%m-%d') <= s.date && s.date <= Date.strptime(params[:user][:end_date], '%Y-%m-%d') && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
      @results_hash = {}
      @revenues_and_margins = @shipments.map{|s| [s.product.name, helpers.revenue_from(s).to_f, helpers.margin_from(s).to_f]}
      @updated_revenues_and_margins = 
      @revenues_and_margins.each do |x| 
        @results_hash[x[0]] = {:Revenue => [], :Margin => []}
      end
      @revenues_and_margins.each do |x|
        @results_hash[x[0]][:Revenue] << x[1]
        @results_hash[x[0]][:Margin] << x[2]
      end
      # @results_hash.keys.each do |key|
      #   @results_hash[key][:total_revenue] = helpers.sum_of(@results_hash[key][:Revenue])
      #   @results_hash[key][:total_margin] = helpers.sum_of(@results_hash[key][:Margin])
      # end
      @updated_results_hash = {}
      puts @results_hash
      @results_hash.keys.each do |key|
        @updated_results_hash[key] = {}
        @results_hash[key].keys.each do |key2|
          @updated_results_hash[key][key2] = @results_hash[key][key2].reduce(:+)
        end
      end

      puts @updated_results_hash
    # render 'revenue-margin'
    end
  end

  def cash_flow
    if params[:commit]
      current_user.update_attributes(user_params)
      @start_date = Date.strptime(params[:user][:start_date], '%Y-%m-%d')
      @end_date = Date.strptime(params[:user][:end_date], '%Y-%m-%d')
      @rev_shipments = Shipment.select{|s| (@start_date - 30) <= s.date && s.date <= (@end_date - 30) && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
      @cost_shipments = Shipment.select{|s| (@start_date + 30) <= s.date && s.date <= (@end_date + 30) && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
      @flow_hash = {}
      @cumulative_cash_flow = 0
      @start_date.upto(@end_date).each do |date|
        @flow_hash[date] = 0
      end
      @rev_shipments.each do |s|
        revenue = helpers.revenue_from(s)
        @flow_hash[s.date + 30] += revenue 
      end
      @cost_shipments.each do |s|
        cost = helpers.cost_of(s)
        @flow_hash[s.date-30] -= cost
      end

      # @shipments = Shipment.select{|s| Date.strptime(params[:user][:start_date], '%Y-%m-%d') <= s.date && s.date <= Date.strptime(params[:user][:end_date], '%Y-%m-%d') && params[:user][:min_confidence].to_i <= s.project.confidence && s.project.confidence <= params[:user][:max_confidence].to_i}
      # @cash_flow = helpers.cash_flow_for(@shipments, Date.strptime(params[:user][:start_date]), Date.strptime(params[:user][:end_date]))
    # render 'cash-flow'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :confidence, :rep, :notes, :application, :distributor_id)
  end

  def user_params
    params.require(:user).permit(:start_date, :end_date, :min_confidence, :max_confidence)
  end

end