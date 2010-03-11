##########################################################################################
# File:     application_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "application" (i.e. main) controller.
##########################################################################################

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all             # include all helpers, all the time
  protect_from_forgery    # see ActionController::RequestForgeryProtection for details

  # make the following methods available in the view
  helper_method :current_user, :current_user_session, :admin?

  # filter passwords from the request log
  filter_parameter_logging :password, :password_confirmation

  # for mobile devices connecting to web system, this will change the CSS template
  #   - will have CSS for PC users, iphone users and generic mobile users.
  #   - pass in parameter value of true to the has_mobile_fu method to force the 
  #     mobile CSS template to be shown.
  has_mobile_fu true

  protected
  def authorize
    # if the current user does not have admin privileges, then display an error message
    # and redirect to the url root
    unless admin?
      flash[:error] = "Unauthorized access."
      redirect_to root_url
      false
    end
  end

  def admin?
    # check the current user's admin attribute and return that value
    if current_user
      @current_user.is_admin?
    else
      false
    end
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end

  # for authentication purposes: users must be logged in to have access to
  # most functionality; i.e. the schedule log.
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page."
      redirect_to new_user_session_url
      return false
    end
  end

  # for authentication purposes: this is for functionality which the user
  # needs to be logged out to access; i.e. the login page.
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page."
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
