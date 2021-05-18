
WITH a AS 
(SELECT exam_id,
        student_id, 
        MAX(score) OVER (PARTITION BY exam_id) highest_score,
        MIN(score) OVER (PARTITION BY exam_id) lowest_score
FROM Exam) 
  
SELECT DISTINCT e.student_id, s.student_name
FROM Exam e
JOIN Student s ON e.student_id = s.student_id
WHERE e.student_id NOT IN (SELECT e.student_id
                           FROM Exam e
                           JOIN a ON a.exam_id = e.exam_id AND a.student_id = e.student_id
                           WHERE e.score = a.highest_score OR e.score = a.lowest_score)
ORDER BY e.student_id



/*

 a     
 
{"headers": ["exam_id", "student_id", "highest_score", "lowest_score"], 
 "values": [[10, 1, 90, 70], [10, 2, 90, 70], [10, 3, 90, 70], 
            [20, 1, 80, 80], 
            [30, 1, 90, 70], [30, 3, 90, 70], [30, 4, 90, 70], 
            [40, 1, 80, 60], [40, 2, 80, 60], [40, 4, 80, 60]]}
*/

SELECT DISTINCT e.student_id, s.student_name
FROM Exam e
LEFT JOIN Student s on s.student_id = e.student_id
WHERE e.student_id NOT IN ( SELECT student_id
                            FROM (SELECT student_id,
                                  RANK() OVER (PARTITION BY exam_id ORDER BY score) AS lowest_s,
                                  RAnK() OVER (PARTITION BY exam_id ORDER BY score DESC) AS highest_s
                                  FROM Exam) t
                             WHERE t.lowest_s = 1 OR t.highest_s = 1)
ORDER BY 1
