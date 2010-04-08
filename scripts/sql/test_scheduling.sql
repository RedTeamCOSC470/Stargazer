BEGIN
  dbms_scheduler.create_job(job_name        => 'myjob',
                            job_type        => 'executable',
                            job_action      => 'c:\stargazer\test.bat',
                            enabled         => TRUE,
                            auto_drop       => TRUE);
END;
/

BEGIN
  dbms_scheduler.run_job('myjob');
END;
/

BEGIN
  dbms_scheduler.drop_job('myjob');
END;
/

SELECT * FROM SCHEDULES;

begin
 dbms_scheduler.create_job('myjob',
   job_action=>'C:\WINDOWS\SYSTEM32\CMD.EXE',
   number_of_arguments=>4,
   auto_drop => false,
   job_type=>'executable', enabled=>false);
 dbms_scheduler.set_job_argument_value('myjob',1,'/q');
 dbms_scheduler.set_job_argument_value('myjob',2,'/c');
 dbms_scheduler.set_job_argument_value('myjob',3,'c:\stargazer\test.bat');
 dbms_scheduler.set_job_argument_value('myjob',4,'foobar');
 dbms_scheduler.enable('myjob');
 end;
/


-- Trig
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
/

SELECT * FROM schedules;
DELETE FROM schedules;
DESC SCHEDULES;
INSERT INTO SCHEDULES VALUES (1, "2014-05-06 04:36:00",  1, 2, SYSDATE, SYSDATE, 10003, 0, 0, 12, 1, '1/1000', NULL, SYSDATE, 34.04);

DROP TRIGGER schedules_trg_biud;

SELECT TO_NUMBER('52.44', '99') FROM DUAL;
select TO_NUMBER(substr(TO_CHAR('1000.5821', '9999.99'), -2, 2)) FROM DUAL;


-- test table
CREATE TABLE TEST (ID NUMBER, H VARCHAR2(5), M VARCHAR2(5), S VARCHAR2(5), DMAJ VARCHAR2(5), DMIN VARCHAR2(5));
DROP TABLE TEST;
SELECT * FROM TEST;

SELECT start_time FROM schedules WHERE ID = 10007;

BEGIN
  --dbms_scheduler.enable('STARGAZER_10007');
  dbms_scheduler.drop_job('STARGAZER_10017');
END;
/

SELECT * FROM USER_SCHEDULER_JOBS;

SELECT SYSDATE FROM DUAL;
select trunc(sysdate) from dual;

BEGIN
dbms_scheduler.create_job('test_lmao',
        job_action => 'C:\WINDOWS\SYSTEM32\CMD.EXE',
        number_of_arguments => 3,
        auto_drop => false,
        job_type =>'executable', 
        enabled => FALSE);
      dbms_scheduler.set_job_argument_value('test_lmao',1,'/q');
      dbms_scheduler.set_job_argument_value('test_lmao',2,'/c');
      dbms_scheduler.set_job_argument_value('test_lmao',3,'c:\stargazer\meade_park.bat');
      dbms_scheduler.enable('test_lmao');
END;
/
      
BEGIN
  dbms_scheduler.enable('STARGAZER_10007');
END;
/
