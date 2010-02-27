# == Schema Information
#
# Table name: celestial_objects
#
#  name :string(255)     not null, primary key
#

##########################################################################################
# File:     celestial_object.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The model for celestial objects which belong in the library.
##########################################################################################

class CelestialObject < ActiveRecord::Base
  has_one :schedule, :primary_key => "name", :foreign_key => "object_name"
  set_primary_key :name
end

