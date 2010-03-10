##########################################################################################
# File:     info_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "info" controller.
# =>        Controller for semi-static pages with no models (i.e. an "about" page)
##########################################################################################

class InfoController < ApplicationController

  # require authentication on all pages
  before_filter :require_user

end
