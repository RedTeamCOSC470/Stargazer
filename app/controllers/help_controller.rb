##########################################################################################
# File:     help_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "help" controller.
# =>        Controller for online help pages.
##########################################################################################

class HelpController < ApplicationController

  # require authentication on all pages
  before_filter :require_user

  # require authorization on all pages except index and show
  before_filter :authorize, :except => [:index, :gallery, :log, :login, :schedule]
  
end
