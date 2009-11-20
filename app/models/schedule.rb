##########################################################################################
# File:     schedule.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "schedule" model.
# =>        A "schedule" belongs to a specific "user".
##########################################################################################
# == Schema Information
#
# Table name: schedules
#
#  id                 :integer         not null, primary key
#  start_time         :datetime
#  latitude           :float
#  longitude          :float
#  exposure           :integer
#  number_of_pictures :integer
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer
##########################################################################################

class Schedule < ActiveRecord::Base
	belongs_to :user
	
	# make sure schedule cannot be before present time
	# plugin used: validates_timeliness
	# see: http://www.railslodge.com/plugins/1160-validates-timeliness for using the plugin
	validates_date :start_time, :after => Time.now, :after_message => "must be in the future"
	
	# make all fields required
	validates_presence_of :latitude, :longitude, :exposure, :number_of_pictures
	
	# make sure users may not enter non-number or negative values
	validates_numericality_of :latitude, :longitude, :greater_than_or_equal_to => 0
	
	# make sure users may only enter integer values for exposure and number_of_pictures
	validates_numericality_of :number_of_pictures, :exposure, :only_integer => true, :message => "must be an integer"
end
