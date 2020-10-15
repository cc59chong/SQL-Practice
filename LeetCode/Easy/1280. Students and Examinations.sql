/*此题的重点在于没有attend exam要用0表示出来，以及First, CROSS JOIN，Second, LEFT JOIN*/

SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.subject_name) AS attended_exams 
FROM (Students s, Subjects sub) /*FROM Students s CROSS JOIN Subjects sub */
LEFT JOIN Examinations e ON s.student_id = e.student_id and sub.subject_name = e.subject_name
GROUP BY s.student_id, sub.subject_name
ORDER BY s.student_id, sub.subject_name;


/*----*****************************/
/* WITH() */
with student_subjects as (select s1.student_id, s1.student_name, s2.subject_name 
                          from Students s1, Subjects s2)
select s.student_id, s.student_name, s.subject_name, count(e.subject_name) as attended_exams from student_subjects s
left join Examinations e on s.student_id = e.student_id and s.subject_name = e.subject_name group by 1,3 order by 1,3