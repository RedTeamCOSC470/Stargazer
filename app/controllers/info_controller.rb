##########################################################################################
# File:     info_controller.rb
# Project:  Stargazer
# Author:   Rob
# Desc:     The "info" controller.
# =>        Controller for semi-static pages with no models (i.e. Online Help view)
##########################################################################################

class InfoController < ApplicationController
  before_filter :require_user
  
  def about
  end

  def help
  end

end
