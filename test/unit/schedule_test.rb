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
#

require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

  def setup
  	# create a schedule with correct input values for the following tests
  	@schedule = Schedule.new
  	@schedule.start_time = "2014-05-06 04:36:00"
  	@schedule.latitude = 65.29
  	@schedule.longitude = 34.04
  	@schedule.exposure = 12
  	@schedule.number_of_pictures = 2
  end
  
  # Tests for schedule values:
  def test_schedule_time_cannot_be_before_current_time
  	@schedule.start_time = "2004-05-06 04:36:00"
  	assert !@schedule.save, "Worked? Saved a schedule to position itself in the past."
  end
  
  # Tests for latitude coordinate values:
  def test_latitude_coordinate_must_be_a_number
  	@schedule.latitude = "abc"
  	assert !@schedule.save, "Worked? Saved a non-number latitude value."
  end
  
  def test_no_negative_latitude_coordinate_can_be_entered
  	# enter a negative number
  	@schedule.latitude = -15.04
  	assert !@schedule.save, "Worked? Saved a negative latitude value."
  	
  	# enter a positive number
  	@schedule.latitude = 15.04
  	assert @schedule.save
  end
  
  def test_user_must_enter_value_for_latitude
  	@schedule.latitude = nil
  	assert !@schedule.save, "Worked? Saved a nil value for latitude."
  end
  
  # Tests for longitude coordinate values:
  def test_lonitude_coordinate_must_be_a_number
  	@schedule.longitude = "abc"
  	assert !@schedule.save, "Worked? Saved a non-number longitude value."
  end
  
  def test_no_negative_longitude_coordinate_can_be_entered
  	# enter a negative number
  	@schedule.longitude = -12.02
  	assert !@schedule.save, "Worked? Saved a negative longitude value."
  	
  	# enter a positive number
  	@schedule.longitude = 12.02
  	assert @schedule.save
  end
  
  def test_user_must_enter_value_for_longitude
  	@schedule.longitude = nil
  	assert !@schedule.save, "Worked? Saved a nil value for longitude."
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
  	# try to enter a non-integer
  	@schedule.number_of_pictures = "f"
    assert !@schedule.save, "Worked? Saved a string." 
  	@schedule.number_of_pictures = 2.01
    assert !@schedule.save, "Worked? Saved a float." 
    
    # should be able to save when an integer is entered
  	@schedule.number_of_pictures = 2
  	assert @schedule.save
  end
  
  def test_user_must_enter_value_for_number_of_pictures
  	@schedule.number_of_pictures = nil
  	assert !@schedule.save, "Worked? Saved a nil value for number_of_pictures."
  end
  
end
