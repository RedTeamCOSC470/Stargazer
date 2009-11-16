class AddUserToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :user_id, :integer
  end

  def self.down
    remove_column :schedules, :user_id
  end
end
