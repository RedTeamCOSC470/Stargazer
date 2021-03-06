##########################################################################################
# File:     schedules_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "schedules" controller.
# =>        Controller for the "schedule" model and views.
# =>        Allows for: index, show, new, create, update, destroy
##########################################################################################

class SchedulesController < ApplicationController
  
  before_filter :require_user
  before_filter :set_date

  # GET /schedules
  # GET /schedules.xml
  def index

    # find all schedules by that date and add pagination
    @schedules = Schedule.paginate :page => params[:page], :per_page => 10, :order => "start_time",
                                   :conditions => ['start_time LIKE ?', "%#{session[:search]}%"]

    # the default time used for filtering schedules
    # if no search parameters are given, set it to the current date
    #if params[:search].blank?
    #  @default_time = Time.now.year.to_s + "-" + "%02d" % Time.now.month.to_s + "-" + "%02d" % Time.now.day.to_s
    #else
    #  @default_time = params[:search]
    #end

    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.xml  { render :xml => @schedules }
      format.js {
        render :update do |page|
          page.replace_html 'results', :partial => 'schedule'
        end
      }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show

    # any user can see any schedule
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.mobile
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.xml
  def new

    # must remember which user built the schedule
    @schedule = @current_user.schedules.build

    respond_to do |format|
      format.html # new.html.erb
      format.mobile
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit

    # check to see if the current user is an admin
    # otherwise, the user must own that schedule in order to access the page
    is_user_admin?
  end

  # POST /schedules
  # POST /schedules.xml
  def create

    # must remember which user built the schedule
    @schedule = @current_user.schedules.build(params[:schedule])

    respond_to do |format|
      if @schedule.save
        flash[:notice] = 'Schedule was successfully created.'
        format.html { redirect_to(@schedule) }
        format.xml  { render :xml => @schedule, :status => :created, :location => @schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.xml
  def update

    # check to see if the current user is an admin
    # otherwise, the user must own that schedule in order to edit it
    is_user_admin?

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        flash[:notice] = 'Schedule was successfully updated.'
        format.html { redirect_to(@schedule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.xml
  def destroy

    # check to see if the current user is an admin
    # otherwise, the user must own that schedule in order to delete it
    is_user_admin?
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.mobile { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
  
  # for mobile users with javascript disabled, will display a separate page for confirmation
  def confirm_delete
	is_user_admin?
  end

  private
  def is_user_admin?
    # check to see if the current user is an admin
    # otherwise, the user must own that schedule in order to edit it
    if @current_user.is_admin?
      @schedule = Schedule.find(params[:id])
    else
      @schedule = @current_user.schedules.find(params[:id])
    end
  end
  
  def set_date
  	if params[:search].present?
  		session[:search] = Date.parse(params[:search]).to_s
  	end
  	session[:search] = Date.today.to_s if session[:search].blank?
  end
  
end
