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
#  exposure           :integer
#  number_of_pictures :integer
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer
#  right_ascension    :time
#  declination        :integer
#  area_width         :integer
#  area_height        :integer
#  zoom               :integer
#  iso                :integer
#  shutter            :string(255)
#  duration           :float
##########################################################################################

class Schedule < ActiveRecord::Base
	belongs_to :user
	has_many :images
	
	# duration_text is a virtual attribute which holds the schedule's duration as a string
	# it needs to be parsed and assigned from a string into a datetime format
	attr_accessor :duration_text
	before_validation :parse_and_assign_duration
	
	# make sure schedule cannot be before present time
	# plugin used: validates_timeliness, see: http://www.railslodge.com/plugins/1160-validates-timeliness
	validates_datetime :start_time, :after => lambda { Time.now }, :after_message => "must be in the future"
	
	# make some fields required
	validates_presence_of :exposure, :declination, :right_ascension
	
	# validates that the user has entered a duration type (number_of_pictures or duration)
	validates_presence_of :number_of_pictures, :if => "duration_text.blank?"
	validates_presence_of :duration_text, :if => "number_of_pictures.blank?"
	validate :allow_only_one_duration_type_specified
	
	# make sure users may not enter non-number or negative values
	validates_numericality_of :declination, :greater_than_or_equal_to => 0, :allow_blank => true
	
	# make sure users can not enter a duration that is absurdly long
	validates_numericality_of :duration, :less_than => ChronicDuration.parse('5 hours'), 
	                :message => "must be less than 5 hours", :allow_blank => true
	
	# make sure users may only enter integer values for exposure and number_of_pictures
	validates_numericality_of :exposure, :only_integer => true, :message => "must be an integer"
	validates_numericality_of :number_of_pictures, :only_integer => true, :allow_blank => true, :message => "must be an integer"
	
	# following used for easier search and retrieval of records pertaining to schedules
	# e.g. Schedule.highest_exposure returns the object with the highest exposure value in the Schedules table
	named_scope :highest_exposure,	{:order => "exposure DESC", :limit => 1}
  named_scope :search_by_date, lambda { |*args|
	    date = args.first.to_date rescue nil
	    {:conditions => ["date(start_time, 'start of day') = ?", (date)]} if args.first.present?
    }
  named_scope :order_by_recent, {:order => "start_time ASC"}

  def after_find
    #duration_text = ChronicDuration.output(duration)
  end
  
  # for displaying the schedule's duration in a format such as "5 mins" as opposed to the original datetime format
  # rescue is used here to return empty string if no duration type was used (instead, user entered number of pics)
  def output_duration
    ChronicDuration.output(self.duration) rescue nil
  end
  
  private
  def parse_duration_text
    if duration_text.present?
      if ChronicDuration.parse(duration_text).nil?
        errors.add(:duration_text, "was invalid")
      end
    end
  end
  
  # if the user has inputted a duration as text in the text field, then parse it into datetime format
  # then assign the formatted text as the schedule's duration
  def parse_and_assign_duration
    self.duration = ChronicDuration.parse(self.duration_text) if self.duration_text.present?
  end
   
  # used as a custom-built validation to ensure that user has not inputted two types of duration formats
  def allow_only_one_duration_type_specified
    if duration_text.present? && number_of_pictures.present?
      errors.add("Two duration types are entered which")
    end
   end
   
end
