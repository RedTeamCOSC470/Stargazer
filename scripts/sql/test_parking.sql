BEGIN
    dbms_scheduler.create_job('STARGAZER_PARK',
        job_action => 'C:\WINDOWS\SYSTEM32\CMD.EXE',
        number_of_arguments => 3,
        auto_drop => FALSE,
        job_type =>'executable', 
        enabled => FALSE);
      dbms_scheduler.set_job_argument_value('STARGAZER_PARK',1,'/q');
      dbms_scheduler.set_job_argument_value('STARGAZER_PARK',2,'/c');
      dbms_scheduler.set_job_argument_value('STARGAZER_PARK',3,'c:\stargazer\stargazer_park.bat');
      COMMIT;
END;
/

BEGIN
      dbms_scheduler.run_job('STARGAZER_PARK');
END;
/


BEGIN
      dbms_scheduler.drop_job('STARGAZER_PARK');
END;
/

SELECT * FROM USER_SCHEDULER_JOBS;

