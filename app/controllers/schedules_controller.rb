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
  
  # GET /schedules
  # GET /schedules.xml
  def index
    
    # check to see if user has selected view all button or not
    if params[:commit] == "Go"
      search_date = "#{params[:date]['get(1i)']}-#{params[:date]['get(2i)']}-#{params[:date]['get(3i)']}" rescue nil
    else
      search_date = nil
    end
    @schedules = Schedule.search_by_date(search_date).order_by_recent

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
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    
    # check to see if the current user is an admin
    # otherwise, the user must own that schedule in order to access the page
    if @current_user.is_admin?
      @schedule = Schedule.find(params[:id])
    else
      @schedule = @current_user.schedules.find(params[:id])
    end
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
    if @current_user.is_admin?
      @schedule = Schedule.find(params[:id])
    else
      @schedule = @current_user.schedules.find(params[:id])
    end

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
    if @current_user.is_admin?
      @schedule = Schedule.find(params[:id])
    else
      @schedule = @current_user.schedules.find(params[:id])
    end
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to(schedules_url) }
      format.xml  { head :ok }
    end
  end
end
