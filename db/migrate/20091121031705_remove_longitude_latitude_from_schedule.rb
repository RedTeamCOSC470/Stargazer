class RemoveLongitudeLatitudeFromSchedule < ActiveRecord::Migration
  def self.up
    remove_column :schedules, :longitude
    remove_column :schedules, :latitude
  end

  def self.down
    add_column :schedules, :longitude, :float
    add_column :schedules, :latitude, :float
  end
end
