SELECT * FROM schedules 
WHERE (TO_DATE('2010-02-18','YYYY-MM-DD HH24:MI:SS')) BETWEEN (start_time AND start_time+duration/24/60/60);

SELECT start_time, start_time+(NVL(duration,300)/24/60/60) FROM schedules;

SELECT start_time, start_time+(NVL(duration,300)/24/60/60) FROM schedules
WHERE (TO_DATE('2010-02-18 9:55:00','YYYY-MM-DD HH24:MI:SS')) >= start_time
AND (TO_DATE('2010-02-18 9:55:00','YYYY-MM-DD HH24:MI:SS')) <= start_time+(NVL(duration,300)/24/60/60);

SELECT duration FROM schedules;

SELECT * FROM schedules 
WHERE TO_DATE('2010-02-18','YYYY-MM-DD HH24:MI:SS') BETWEEN ((start_time) AND (start_time+(NVL(duration,300)/24/60/60)));

SELECT *
FROM   schedules
WHERE  ((to_date('2010-02-18', 'YYYY-MM-DD HH24:MI SS')) >= start_time AND
       to_date('2010-02-18', 'YYYY-MM-DD HH24:MI SS') <=
       start_time + (nvl(duration, 300) / 24 / 60 / 60))
AND    NOT (to_date('2010-02-18', 'YYYY-MM-DD HH24:MI SS') BETWEEN start_time AND
       start_time + (nvl(duration, 300) / 24 / 60 / 60));
       
       
SELECT *
FROM   schedules
WHERE  (to_date('2010-02-18 9:55:00', 'YYYY-MM-DD HH24:MI SS') BETWEEN start_time AND
       start_time + (nvl(duration, 300) / 24 / 60 / 60));
       
SELECT *
FROM   schedules
WHERE  (to_date('2010-02-18 8:30:00', 'YYYY-MM-DD HH24:MI SS') 
BETWEEN start_time 
        AND start_time + (nvl(duration, 300) / 24 / 60 / 60))
OR      (to_date('2010-02-18 10:30:00', 'YYYY-MM-DD HH24:MI SS') 
BETWEEN start_time 
        AND start_time + (nvl(duration, 300) / 24 / 60 / 60))
OR    start_time 
BETWEEN (to_date('2010-02-18 8:30:00', 'YYYY-MM-DD HH24:MI SS')) 
        AND (to_date('2010-02-18 10:30:00', 'YYYY-MM-DD HH24:MI SS'))
OR    start_time + (nvl(duration, 300) / 24 / 60 / 60)
BETWEEN (to_date('2010-02-18 8:30:00', 'YYYY-MM-DD HH24:MI SS')) 
        AND (to_date('2010-02-18 10:30:00', 'YYYY-MM-DD HH24:MI SS'));

SELECT * FROM schedules 
WHERE (TO_DATE('2010-02-18 08:30:00','YYYY-MM-DD HH24:MI:SS') 
BETWEEN start_time AND (start_time + (nvl(duration, 300)/24/60/60))) 
OR (TO_DATE('2010-02-18 08:30:00','YYYY-MM-DD HH24:MI:SS') + nvl(30000, 300)/24/60/60) 
BETWEEN start_time AND (start_time + (nvl(duration, 300)/24/60/60)) 
OR start_time BETWEEN TO_DATE('2010-02-18 08:30:00','YYYY-MM-DD HH24:MI:SS') 
AND (TO_DATE('2010-02-18 08:30:00','YYYY-MM-DD HH24:MI:SS') + (nvl(30000, 300)/24/60/60)) 
OR (start_time + (nvl(duration, 300)/24/60/60)) BETWEEN TO_DATE('2010-02-18 08:30:00','YYYY-MM-DD HH24:MI:SS') 
AND (TO_DATE('2010-02-18 08:30:00','YYYY-MM-DD HH24:MI:SS') + nvl(30000, 300)/24/60/60)
