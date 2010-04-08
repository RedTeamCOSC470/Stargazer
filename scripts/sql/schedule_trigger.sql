-- Trig
CREATE OR REPLACE TRIGGER schedules_trg_biud
BEFORE INSERT OR UPDATE OR DELETE
ON schedules
FOR EACH ROW
  DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    -- Celestial object which is a part of the library. Example: '47 TUCANAE'
    celestial_object VARCHAR2(255) := NULL;
    
    -- Right Ascension coordinates. Example: 15:23:40
    hours NUMBER := 0;
    minutes NUMBER := 0;
    seconds NUMBER := 0;
    coords_ra VARCHAR2(255) := NULL;
    -- Declination coordinates. Example: 15.3
    degrees_major NUMBER := 0;
    degrees_minor NUMBER := 0;
    coords_dec VARCHAR2(255) := NULL;
    
    -- Switch for duration: Example: -d for duration, -n for number of pictures
    duration_switch VARCHAR2(2) := NULL;
    duration_value NUMBER := 0;
  BEGIN
    
    -- Parse any necessary data
    IF INSERTING OR UPDATING THEN
      -- Parse the hours, minutes and seconds for Right Ascension
      hours := TO_NUMBER(TO_CHAR(:NEW.right_ascension, 'HH24'));
      minutes := TO_NUMBER(TO_CHAR(:NEW.right_ascension, 'MI'));
      seconds := TO_NUMBER(TO_CHAR(:NEW.right_ascension, 'SS'));
      coords_ra := hours || ':' || minutes || ':' || seconds;
      -- Parse the degrees for Declination
      degrees_major := TO_NUMBER(TO_CHAR(:NEW.declination, '999'));
      degrees_minor := TO_NUMBER(substr(TO_CHAR(:NEW.declination, '999.99'), -2, 2));
      coords_dec := degrees_major || '.' || degrees_minor;
      -- Retrieve value for Celestial_Object
      celestial_object := :NEW.object_name;
      -- Get the duration type (either duration or number of pictures)
      IF :NEW.duration IS NOT NULL THEN
        duration_switch := '-d';
        duration_value := :NEW.duration;
      ELSE 
        duration_switch := '-n';
        duration_value := :NEW.number_of_pictures;
      END IF;
    END IF;
    
    -- Drop a scheduled job if needed
    IF UPDATING OR DELETING THEN
      dbms_scheduler.drop_job('STARGAZER_' || :OLD.id);
    END IF;
    
    -- Create the job if needed
    IF INSERTING OR UPDATING THEN
      IF celestial_object IS NOT NULL THEN
        -- Create the job which uses celestial objects for coordinates
        dbms_scheduler.create_job('STARGAZER_' || :NEW.id,
          job_action => 'C:\WINDOWS\SYSTEM32\CMD.EXE',
          number_of_arguments => 10,
          start_date => :NEW.start_time,
          auto_drop => FALSE,
          job_type =>'executable', 
          enabled => FALSE);
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 1, '/q');
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 2, '/c');
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 3, 'c:\stargazer\stargazer_object.bat');
        -- Celestial Object value:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 4, '"' || celestial_object || '"');
        -- Shutter speed:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 5, :NEW.shutter);
        -- ISO:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 6, to_char(:NEW.iso));
        -- Exposure:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 7, to_char(:NEW.exposure));
        -- Schedule ID:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 8, to_char(:NEW.id));
        -- Duration or Number of Pictures. Example: '-d 300', '-n 40'
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 9, duration_switch);
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 10, to_char(duration_value));
        dbms_scheduler.enable('STARGAZER_' || :NEW.id);
      ELSE
        -- Create the job which uses coordinate values (Right Ascension and Declination)
        dbms_scheduler.create_job('STARGAZER_' || :NEW.id,
          job_action => 'C:\WINDOWS\SYSTEM32\CMD.EXE',
          number_of_arguments => 11,
          start_date => :NEW.start_time,
          auto_drop => FALSE,
          job_type =>'executable', 
          enabled => FALSE);
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 1, '/q');
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 2, '/c');
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 3, 'c:\stargazer\stargazer_coordinates.bat');
        -- Right Ascension values:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 4, coords_ra);
        -- Declination values:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 5, coords_dec);
        -- Shutter speed:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 6, :NEW.shutter);
        -- ISO:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 7, to_char(:NEW.iso));
        -- Exposure:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 8, to_char(:NEW.exposure));
        -- Schedule ID:
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 9, to_char(:NEW.id));
        -- Duration or Number of Pictures. Example: '-d 300', '-n 40'
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 10, duration_switch);
        dbms_scheduler.set_job_argument_value('STARGAZER_' || :NEW.id, 11, to_char(duration_value));
        dbms_scheduler.enable('STARGAZER_' || :NEW.id);
      END IF;
    END IF;
  COMMIT;
  END;
/
