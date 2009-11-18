##########################################################################################
# File:     user_sessions_controller.rb
# Project:  Stargazer
# Author:   Rob
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
  
  def create  
    @user_session = UserSession.new(params[:user_session])  
    if @user_session.save  
      flash[:notice] = "Successfully logged in."  
      redirect_to root_url  
    else  
      render :action => 'new'  
    end  
  end  
  
  def destroy  
    @user_session = UserSession.find  
    @user_session.destroy  
    flash[:notice] = "Successfully logged out."  
    redirect_to login_path  
  end  
end
