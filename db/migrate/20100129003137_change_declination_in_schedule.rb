class ChangeDeclinationInSchedule < ActiveRecord::Migration
  def self.up
    change_column :schedules, :declination, :float
  end

  def self.down
  end
end
