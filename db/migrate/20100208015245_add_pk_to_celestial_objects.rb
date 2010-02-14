class AddPkToCelestialObjects < ActiveRecord::Migration
  def self.up
      execute <<-SQL
        ALTER TABLE celestial_objects
        ADD CONSTRAINT celestial_objects_pk
        PRIMARY KEY (name)
      SQL
  end

  def self.down
      execute <<-SQL
        ALTER TABLE celestial_objects
        DROP CONSTRAINT celestial_objects_pk
      SQL
  end
end
