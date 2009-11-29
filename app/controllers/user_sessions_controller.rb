##########################################################################################
# File:     user_sessions_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "user_sessions" controller.
# =>        Controller for the "user_session" model and views.
# =>        Allows for: new, create, destroy
# =>          - new and create means logging in (session is created)
# =>          - destroy means logging out (session is destroyed)
##########################################################################################

class UserSessionsController < ApplicationController
  
  def new  
    @user_session = UserSession.new
  end  
  
  # creating a new user session; in other words, user is "logging in"
  def create  
    @user_session = UserSession.new(params[:user_session])
    
    # if the user session is valid the user will login
    # and then be redirected to the root path of the application  
    if @user_session.save  
      flash[:notice] = "Successfully logged in."  
      redirect_to root_url  
    else  
      render :action => 'new'  
    end  
  end  
  
  # destroying a user session; in other words, user is "logging out"
  def destroy  
    
    # find the session, destroy it and redirect to login page
    @user_session = UserSession.find  
    @user_session.destroy  
    flash[:notice] = "Successfully logged out."  
    redirect_to login_path  
  end  
end
