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

  # for parking of the telescope
  def park

    # run the dbms_scheduler job which will park the telescope immediately
    plsql.dbms_scheduler.run_job('STARGAZER_PARK')

    # output a message
    flash[:notice] = "The parking command has been sent."

    if is_mobile_device?
      # return to the index page
      redirect_to schedules_path
    else
      # return to the previous page
      redirect_to :back
    end
  end

  # for mobile users with javascript disabled, will display a separate page for confirmation
  def confirm_park
  end

end