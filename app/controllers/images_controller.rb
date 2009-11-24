class ImagesController < ApplicationController
  before_filter :require_user
  
  # GET /images
  # GET /images.xml
  def index
    @images = Image.all(:conditions => {:schedule_id => params[:schedule_id]})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
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

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to(@image) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(schedule_images_path(params[:schedule_id])) }
      format.xml  { head :ok }
    end
  end
end
