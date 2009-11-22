class AddDeclinationToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :declination, :integer
  end

  def self.down
    remove_column :schedules, :declination
  end
end
