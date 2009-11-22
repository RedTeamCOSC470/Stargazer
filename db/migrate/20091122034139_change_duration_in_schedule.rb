class ChangeDurationInSchedule < ActiveRecord::Migration
  def self.up
    remove_column :schedules, :duration
    add_column :schedules, :duration, :float
  end

  def self.down
  end
end
