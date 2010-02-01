class ChangeRightAscensionInSchedule < ActiveRecord::Migration
  def self.up
    change_column :schedules, :right_ascension, :time
  end

  def self.down
  end
end
