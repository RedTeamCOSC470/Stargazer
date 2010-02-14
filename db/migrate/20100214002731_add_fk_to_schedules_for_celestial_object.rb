class AddFkToSchedulesForCelestialObject < ActiveRecord::Migration
  def self.up
    add_foreign_key(:schedules, :celestial_objects, :column => "celestial_object", :primary_key => "name")
  end

  def self.down
    remove_foreign_key(:schedules, :celestial_objects)
  end
end
