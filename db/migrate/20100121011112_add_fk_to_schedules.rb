class AddFkToSchedules < ActiveRecord::Migration
  def self.up
      execute <<-SQL
       ALTER TABLE schedules
       ADD CONSTRAINT schedules_fk
       FOREIGN KEY (user_id)
       REFERENCING users(id)
      SQL
  end

  def self.down
      execute <<-SQL
       ALTER TABLE schedules
       DROP CONSTRAINT schedules_fk
      SQL
  end
end
