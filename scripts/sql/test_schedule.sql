BEGIN
  dbms_scheduler.create_job('STARGAZER_TEST4',
        job_action => 'C:\WINDOWS\SYSTEM32\CMD.EXE',
        number_of_arguments => 10,
        start_date => TO_DATE('2010-04-01 6:16 PM', 'YYYY-MM-DD HH12:MI PM'),
        auto_drop => FALSE,
        job_type =>'executable', 
        enabled => FALSE);
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 1, '/q');
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 2, '/c');
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 3, 'c:\stargazer\stargazer_object.bat');
  -- Celestial Object value:
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 4, '47 TUCANAE');
  -- Shutter speed:
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 5, to_char(1/1000));
  -- ISO:
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 6, to_char(100));
  -- Exposure:
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 7, to_char(8));
  -- Schedule ID:
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 8, to_char(10021));
  -- Duration or Number of Pictures. Example: '-d 300', '-n 40'
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 9, '-d');
  dbms_scheduler.set_job_argument_value('STARGAZER_TEST4', 10, to_char(20));
  dbms_scheduler.enable('STARGAZER_TEST4');
  COMMIT;
END;
