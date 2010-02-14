class AddUpperNameIndexToCelestialObjects < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      create index CELESTIAL_OBJECTS_UPPER_NAME on CELESTIAL_OBJECTS (UPPER(NAME))
    SQL
    execute <<-SQL
      BEGIN
        dbms_stats.gather_table_stats(tabname => 'CELESTIAL_OBJECTS', force => true, ownname => user);
      END;
    SQL
  end

  def self.down
    execute <<-SQL
      drop index CELESTIAL_OBJECTS_UPPER_NAME
    SQL
  end
end
