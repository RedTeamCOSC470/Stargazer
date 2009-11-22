class AddIsoToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :iso, :integer
  end

  def self.down
    remove_column :schedules, :iso
  end
end
