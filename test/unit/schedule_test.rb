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
#  duration           :integer(38)
#  right_ascension    :datetime
#  declination        :integer(38)
#  object_name        :string(255)
#

##########################################################################################
# File:     schedule_test.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     Unit test for the "schedule" model.  
##########################################################################################

require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

  def setup
  	# create a schedule with necessary, correct input values for the following tests
  	@schedule = Schedule.new
  	@schedule.start_time = "2014-05-06 04:36:00"
  	@schedule.right_ascension = Time.now
  	@schedule.declination = 34.04
  	@schedule.exposure = 12
  	@schedule.shutter = "1/1000"
  	@schedule.iso = 400
  	@schedule.zoom = 1
  	@schedule.duration_text = "4 hrs"
  	@schedule.number_of_pictures = nil
  end
  
  def teardown
    @schedule = nil
  end
  
  # Tests for schedule values:
  def test_schedule_time_cannot_be_before_current_time
  	@schedule.start_time = "2004-05-06 04:36:00"
  	assert !@schedule.save, "Worked? Saved a schedule to position itself in the past."
  end
  
  # Tests for right ascension coordinate values:
  def test_user_must_enter_value_for_right_ascension
  	@schedule.right_ascension = nil
  	assert !@schedule.save, "Worked? Saved a nil value for right ascension."
  end
  
  # Tests for declination coordinate values:
  def test_declination_coordinate_must_be_a_number
  	@schedule.declination = "abc"
  	assert !@schedule.save, "Worked? Saved a non-number declination value."
  end
  
  def test_no_negative_declination_coordinate_can_be_entered
  	# enter a negative number
  	@schedule.declination = -12
  	assert !@schedule.save, "Worked? Saved a negative declination value."
  	
  	# enter a positive number
  	@schedule.declination = 12.02
  	assert @schedule.save
  end
  
  def test_user_must_enter_value_for_declination
  	@schedule.declination = nil
  	assert !@schedule.save, "Worked? Saved a nil value for declination."
  end
  
  # Tests for exposure_rating values:
  def test_exposure_rating_cannot_be_past_set_limits
  	@schedule.exposure = 14
  	assert @schedule.save, "Saved!"
  end
  
  def test_exposure_should_be_an_integer
  	# try to enter a non-integer value
  	@schedule.exposure = "f"
    assert !@schedule.save, "Worked? Saved a string." 
  	@schedule.exposure = 2.01
    assert !@schedule.save, "Worked? Saved a float." 
    
  	# should be able to save when an integer is entered
  	@schedule.exposure = 2
  	assert @schedule.save
  end
  
  def test_user_must_enter_value_for_exposure
  	@schedule.exposure = nil
  	assert !@schedule.save, "Worked? Saved a nil value for exposure."
  end
  
  # Tests for number_of_pictures values:
  def test_number_of_pictures_should_be_an_integer
    # make sure duration_text is null
  	@schedule.duration_text = nil
  	
  	# try to enter a non-integer
  	@schedule.number_of_pictures = "f"
    assert !@schedule.save, "Worked? Saved a string." 
  	@schedule.number_of_pictures = 2.01
    assert !@schedule.save, "Worked? Saved a float." 
    
    # should be able to save when an integer is entered
  	@schedule.number_of_pictures = 2
  	assert @schedule.save
  end
  
  def test_user_cannot_enter_two_different_duration_types
  	@schedule.number_of_pictures = 2
  	@schedule.duration_text = "4 hrs"
  	assert !@schedule.save, "Worked? Saved a two types of durations."
  end
  
end

