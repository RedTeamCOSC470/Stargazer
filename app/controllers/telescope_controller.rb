##########################################################################################
# File:     telescope_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "telescope" controller.
# =>        Controller which handles movement of the telescope such as parking.
##########################################################################################

class TelescopeController < ApplicationController

  def park
    # return to the previous page
    redirect_to :back
  end

end