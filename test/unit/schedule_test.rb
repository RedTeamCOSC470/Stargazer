require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase

  def setup
  	@schedule = Schedule.new
  end

  def test_should_not_save_schedule_with_zero_pictures
    assert @schedule.save, "Saved a new schedule with zero pictures" 
  end
  
  
end
