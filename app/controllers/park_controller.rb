##########################################################################################
# File:     park_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "park" controller.
# =>        Controller which handles parking of the telescope.
##########################################################################################

class ParkController < ApplicationController
  
  def index
    # return to the previous page
    redirect_to :back
  end

end
