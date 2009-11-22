class AddAreaHeightToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :area_height, :integer
  end

  def self.down
    remove_column :schedules, :area_height
  end
end
