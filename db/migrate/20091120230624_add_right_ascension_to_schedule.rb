class AddRightAscensionToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :right_ascension, :time
  end

  def self.down
    remove_column :schedules, :right_ascension
  end
end
