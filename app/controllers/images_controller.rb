##########################################################################################
# File:     images_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The controller for handling images.
##########################################################################################

class ImagesController < ApplicationController
  
  # require authentication on all pages
  before_filter :require_user
  
  # require authorization on all pages except index and show
  before_filter :authorize, :except => [:index, :show]
  
  # GET /schedule/1/images
  # GET /schedule/1/images.xml
  def index
    @images = Image.all(:conditions => { :schedule_id => params[:schedule_id] })

    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.xml  { render :xml => @images }
    end
  end

  # GET /schedule/1/images/1
  # GET /schedule/1/images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /schedule/1/images/new
  # GET /schedule/1/images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /schedule/1/images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /schedule/1/images
  # POST /schedule/1/images.xml
  def create
    @image = Schedule.find(params[:schedule_id]).images.new(params[:image])
    
    respond_to do |format|
      if @image.save
        flash[:notice] = 'Image was successfully created.'
        format.html { redirect_to(schedule_images_path(params[:schedule_id])) }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schedule/1/images/1
  # PUT /schedule/1/images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to(schedule_images_path(params[:schedule_id])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule/1/images/1
  # DELETE /schedule/1/images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(schedule_images_path(params[:schedule_id])) }
      format.xml  { head :ok }
    end
  end
end
