class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.datetime :start_time
      t.float :latitude
      t.float :longitude
      t.integer :exposure
      t.integer :number_of_pictures

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
