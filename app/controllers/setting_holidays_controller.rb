class SettingHolidaysController < ApplicationController
  menu_item :setting_holiday
  before_filter :find_project_by_project_id

  before_filter :find_holidays, :only => [ :index, :list ]
  before_filter :find_object, :only => [ :update, :destroy ]

  rescue_from Query::StatementInvalid, :with => :query_statement_invalid

  helper :gantt
  helper :issues
  helper :projects
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
  include SettingHolidaysHelper

  def index
    retrieve_query
    @query.group_by = nil

    @calendars = []
    month = 1
    while month < 13
      @calendars[month] = Redmine::Helpers::Calendar.new(Date.civil(@year, month, 1), current_language, :month)
      month += 1
    end

    render :action => 'index', :layout => false if request.xhr?
  end

  def list
    retrieve_query

    render :action => 'list', :layout => false if request.xhr?
  end

  def show
  end

  def destroy
    if @holiday.destroy
      flash[:notice] = l(:notice_successful_delete)
      redirect_to :action => "index", :project_id => @project
    end
  end

  def new
    @holiday = SettingHoliday.new(:project_id => @project.id, :date => params[:day])

    render :action => 'new', :layout => false if request.xhr?
  end

  def create
    @holiday = SettingHoliday.new(:project_id => @project.id, :date => params[:holiday][:date])
    @holiday.safe_attributes = params[:holiday]
    if @holiday.save
      flash[:notice] = l(:notice_successful_create)
      respond_to do |format|
        format.html { redirect_to project_setting_holidays_index_path(@project) }
        format.api  { render_api_ok }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.api  { render_validation_errors(@holiday) }
      end
    end
  end

  def edit
    if params[:day]
      @holiday = SettingHoliday.find(:first, :conditions => ["project_id = ? and date = ?", @project.id, params[:day]])
    else
      @holiday = nil
    end

    if @holiday == nil
      @holiday = SettingHoliday.new(:project_id => @project.id, :date => params[:day])
    end

    render :action => 'edit', :layout => false if request.xhr?
  end

  def update
    @holiday.safe_attributes = params[:holiday]
    if @holiday.save
      flash[:notice] = l(:notice_successful_update)
      respond_to do |format|
        format.html { redirect_to project_setting_holidays_index_path(@project) }
        format.api  { render_api_ok }
      end
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.api  { render_validation_errors(@holiday) }
      end
    end
  end

private
  def find_holidays
    if params[:year] and params[:year].to_i > 1900
      @year = params[:year].to_i
    end
    @year ||= Date.today.year

    now_year = Date.new(@year, 1, 1)
    next_year = Date.new((@year + 1), 1, 1)
    @holidays = SettingHoliday.find(:all, :conditions => ["project_id = ? and date >= ? and date < ?", @project.id, now_year, next_year], :order => "date ASC")
  end

  def find_object
    @holiday = SettingHoliday.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
