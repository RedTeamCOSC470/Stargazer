class AddShutterToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :shutter, :string
  end

  def self.down
    remove_column :schedules, :shutter
  end
end
