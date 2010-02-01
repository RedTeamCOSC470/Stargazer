class AddTriggerToSchedules < ActiveRecord::Migration
  def self.up
      execute <<-SQL
        CREATE OR REPLACE TRIGGER schedules_trg_biud
        BEFORE INSERT OR UPDATE OR DELETE
        ON schedules
        FOR EACH ROW
          DECLARE
            PRAGMA AUTONOMOUS_TRANSACTION;
            -- Right Ascension coordinates. Example: 15:23:40
            hours NUMBER := 0;
            minutes NUMBER := 0;
            seconds NUMBER := 0;
            -- Declination coordinates. Example: 15.3
            degrees_major NUMBER := 0;
            degrees_minor NUMBER := 0;
          BEGIN
            
            -- Parse any necessary data
            IF INSERTING OR UPDATING THEN
              -- Parse the hours, minutes and seconds for Right Ascension
              hours := to_number(to_char(:NEW.right_ascension, 'HH24'));
              minutes := to_number(to_char(:NEW.right_ascension, 'MI'));
              seconds := to_number(to_char(:NEW.right_ascension, 'SS'));
              -- Parse the degrees for Declination
              degrees_major := TO_NUMBER(TO_CHAR(:NEW.declination, '999'));
              degrees_minor := TO_NUMBER(substr(TO_CHAR(:NEW.declination, '999.99'), -2, 2));
            END IF;
            
            -- Drop a scheduled job if needed
            IF UPDATING OR DELETING THEN
              dbms_scheduler.drop_job('STARGAZER_' || :OLD.id);
            END IF;
            
            -- Create the job if needed
            IF INSERTING OR UPDATING THEN
              dbms_scheduler.create_job('STARGAZER_' || :NEW.id,
                job_action => 'C:\WINDOWS\SYSTEM32\CMD.EXE',
                number_of_arguments => 8,
                start_date => :NEW.start_time,
                auto_drop => FALSE,
                job_type =>'executable', 
                enabled => FALSE);
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,1,'/q');
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,2,'/c');
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,3,'c:\stargazer\ascom.bat');
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,4,to_char(hours));
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,5,to_char(minutes));
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,6,to_char(seconds));
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,7,to_char(degrees_major));
              dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id,8,to_char(degrees_minor));
              dbms_scheduler.enable('STARGAZER_' || :NEW.id);
            END IF;
          COMMIT;
          END;
      SQL
  end

  def self.down
      execute <<-SQL
        DROP TRIGGER schedules_trg_biud;
      SQL
  end
end
