WITH t1 AS
(
SELECT machine_id, process_id, timestamp AS end
FROM Activity
WHERE activity_type = 'end'
GROUP BY machine_id, process_id
    ),
    t2 AS
( 
SELECT machine_id, process_id, timestamp AS start
FROM Activity
WHERE activity_type = 'start'
GROUP BY machine_id, process_id)

SELECT machine_id, ROUND(AVG(processing_time ),3) AS processing_time
FROM 
(SELECT t1.machine_id, (t1.end - t2.start) AS processing_time 
FROM t1
JOIN t2 ON t1.machine_id = t2.machine_id AND t1.process_id = t2.process_id) t3
GROUP BY machine_id

/******************************************************************************/
SELECT machine_id, 
       ROUND(
           (SUM(CASE WHEN activity_type = 'end' THEN timestamp END)-SUM(CASE WHEN activity_type = 'start' THEN timestamp END))
           /COUNT(DISTINCT process_id),
           3) processing_time
FROM Activity
GROUP BY 1

/******************************************************************************/
SELECT s.machine_id, ROUND(AVG(e.timestamp-s.timestamp), 3) AS processing_time
FROM Activity s JOIN Activity e ON
    s.machine_id = e.machine_id AND s.process_id = e.process_id AND
    s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY s.machine_id