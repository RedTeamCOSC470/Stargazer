class AddFkToImages < ActiveRecord::Migration
  def self.up
      execute <<-SQL
        ALTER TABLE images
        ADD CONSTRAINT images_fk
        FOREIGN KEY (schedule_id)
        REFERENCING schedules(id)
      SQL
  end

  def self.down
      execute <<-SQL
        ALTER TABLE images
        DROP CONSTRAINT images_fk
      SQL
  end
end
