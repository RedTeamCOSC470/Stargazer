class AddCelestialObjectToSchedules < ActiveRecord::Migration
  def self.up
    add_column :schedules, :celestial_object, :string
  end

  def self.down
    remove_column :schedules, :celestial_object
  end
end
