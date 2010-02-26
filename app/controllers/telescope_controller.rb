##########################################################################################
# File:     telescope_controller.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "telescope" controller.
# =>        Controller which handles movement of the telescope such as parking.
##########################################################################################

class TelescopeController < ApplicationController

  # require authentication
  before_filter :require_user

  # allow only admins to park the telescope
  before_filter :authorize

  def park

    # run the dbms_scheduler job which will park the telescope immediately
    plsql.dbms_scheduler.run_job('STARGAZER_PARK')

    # return to the previous page
    redirect_to :back
  end

end