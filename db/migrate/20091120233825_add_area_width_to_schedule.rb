class AddAreaWidthToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :area_width, :integer
  end

  def self.down
    remove_column :schedules, :area_width
  end
end
