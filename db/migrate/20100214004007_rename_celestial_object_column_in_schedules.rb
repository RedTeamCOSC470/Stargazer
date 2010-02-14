class RenameCelestialObjectColumnInSchedules < ActiveRecord::Migration
  def self.up
    rename_column(:schedules, :celestial_object, :object_name)
  end

  def self.down
  end
end
