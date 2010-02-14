class CreateCelestialObjects < ActiveRecord::Migration
  def self.up
    create_table :celestial_objects, { :id => false, :primary_key => :name } do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :celestial_objects
  end
end
