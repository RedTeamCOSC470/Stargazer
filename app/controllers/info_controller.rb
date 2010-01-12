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
  
  def about
  end

  def help
  end

end
