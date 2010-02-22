# == Schema Information
#
# Table name: schedules
#
#  id                 :integer(38)     not null, primary key
#  start_time         :datetime
#  exposure           :integer(38)
#  number_of_pictures :integer(38)
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer(38)
#  area_width         :integer(38)
#  area_height        :integer(38)
#  zoom               :integer(38)
#  iso                :integer(38)
#  shutter            :string(255)
#  duration           :decimal(, )
#  right_ascension    :decimal(, )
#  declination        :decimal(, )
#

##########################################################################################
# File:     schedule.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "schedule" model.
# =>        A "schedule" belongs to a specific "user".
##########################################################################################

class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :images
  belongs_to :celestial_object, :foreign_key => "object_name"

  # ensure start_time is a date_time column and not a date
  set_datetime_columns :start_time

  # duration_text is a virtual attribute which holds the schedule's duration as a string
  # it needs to be parsed and assigned from a string into a datetime format
  attr_accessor :duration_text
  before_validation :parse_and_assign_duration

  # check to see if there are time conflicts with other schedules
  validate :invalid_schedule_time

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
  named_scope :highest_exposure,	{ :order => "exposure DESC", :limit => 1 }
  named_scope :search_by_date, lambda { |*args|
    date = args.first.to_date rescue nil
    { :conditions => ["trunc(start_time) = ?", (date)] } if args.first.present?
  }
  named_scope :order_by_recent, { :order => "start_time ASC" }
  named_scope :check_invalid_duration, lambda { |*args|

    # the id number of the current Schedule object
    s_id = args.first rescue nil

    # the time when the new schedule will start
    start = args.second.to_time rescue nil

    # the duration for which the telescope is scheduled for
    # if nil, will default to 4 minutes 50 seconds
    dur = args.third rescue nil

    # need the Schedule object's id and time
    if args.first.present? && args.second.present?
      
      { :conditions => ["id <> ? AND ((? BETWEEN start_time AND (start_time + (nvl(duration, 290)/24/60/60))) " +
              "OR (? + nvl(?, 290)/24/60/60) BETWEEN start_time AND (start_time + (nvl(duration, 290)/24/60/60)) " +
              "OR start_time BETWEEN ? AND (? + (nvl(?, 290)/24/60/60)) " +
              "OR (start_time + (nvl(duration, 290)/24/60/60)) BETWEEN ? AND (? + nvl(?, 290)/24/60/60))",
                        s_id, start, start, dur, start, start, dur, start, start, dur] }
      
    # if the Schedule's object id is not given (i.e. if a new Schedule object is created)
    else
      { :conditions => ["id IS NOT NULL AND ((? BETWEEN start_time AND (start_time + (nvl(duration, 290)/24/60/60))) " +
              "OR (? + nvl(?, 290)/24/60/60) BETWEEN start_time AND (start_time + (nvl(duration, 290)/24/60/60)) " +
              "OR start_time BETWEEN ? AND (? + (nvl(?, 290)/24/60/60)) " +
              "OR (start_time + (nvl(duration, 290)/24/60/60)) BETWEEN ? AND (? + nvl(?, 290)/24/60/60))",
                        start, start, dur, start, start, dur, start, start, dur] }
    end
  }

  # accessor for retrieving celestial object name
  def celestial_object_name
    self.object_name
  end

  # mutator for setting the value of a celestial object's name
  def celestial_object_name=(name)
    self.celestial_object = CelestialObject.find_by_name(name) unless name.blank?
  end

  # check to see if the start_time and duration of a schedule is valid with no conflicts
  def invalid_schedule_time
    if Schedule.check_invalid_duration(self.id, self.start_time, self.duration).count > 0
      errors.add_to_base "Time conflict; a schedule exists and occurs during this time."
    end
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
