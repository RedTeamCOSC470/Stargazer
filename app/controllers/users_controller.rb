##########################################################################################
# File:     users_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "users" controller.
# =>        Controller for the "users" model and views.
# =>        Allows for: index, show, new, create, update, destroy
##########################################################################################

class UsersController < ApplicationController
  before_filter :require_user
  
  # allow only admins to manage users
  # regular users may only edit and update their own profile
  before_filter :authorize, :except => [:edit, :update]

  # GET /users
  # GET /users.xml
  def index
  	@users = User.all
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/new
  # GET /users/new.xml
  def new  
    @user = User.new  
  end  
  
  # POST /users
  # POST /users.xml
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      flash[:notice] = "Registration successful."  
      redirect_to users_path
    else  
      render :action => 'new'  
    end  
  end 
  
  # GET /users/1/edit
  def edit
    
    # when editing, ensure the user is either editing his own profile
    # if the user is an admin, then he may edit any profile
  	if admin?
      @user = User.find(params[:id])
    else
	    @user = @current_user
    end
  end 
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    
    # when updating, ensure the user is either updating his own profile
    # if the user is an admin, then he may update any profile
    if admin? 
      @user = User.find(params[:id])
    else
	    @user = @current_user	
    end
    
    if @user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated profile."  
      redirect_to root_url  
    else  
      render :action => 'edit'  
    end  
  end 
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
