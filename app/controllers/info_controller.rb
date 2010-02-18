##########################################################################################
# File:     info_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "info" controller.
# =>        Controller for semi-static pages with no models (i.e. Online Help view)
##########################################################################################

class InfoController < ApplicationController

  # require authentication on all pages
  before_filter :require_user

  # allow only admins to park the telescope
  before_filter :authorize, :except => [:about, :help]

  def about
  end

  def help
  end

  # for parking the telescope
  def park

    # return to the previous page
    redirect_to :back
  end

end
