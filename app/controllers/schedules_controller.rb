##########################################################################################
# File:     schedules_controller.rb
# Project:  Stargazer
# Author:   Rob
# Desc:     The "schedules" controller.
# =>        Controller for the "schedule" model and views.
# =>        Allows for: index, show, new, create, update, destroy
##########################################################################################

class SchedulesController < ApplicationController
  before_filter :require_user
  
  # GET /schedules
  # GET /schedules.xml
  def index
    @schedules = Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.xml
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.xml
  def new
    @schedule = @current_user.schedules.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    if @current_user.is_admin?
      @schedule = Schedule.find(params[:id])
    else
      @schedule = @current_user.schedules.find(params[:id])
    end
  end

  # POST /schedules
  # POST /schedules.xml
  def create
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
