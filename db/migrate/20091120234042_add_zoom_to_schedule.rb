class AddZoomToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :zoom, :integer
  end

  def self.down
    remove_column :schedules, :zoom
  end
end
