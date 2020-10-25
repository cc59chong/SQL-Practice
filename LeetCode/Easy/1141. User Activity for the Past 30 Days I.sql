
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;

select activity_date as day, count(distinct user_id) as active_users 
from Activity
where datediff("2019-07-27", activity_date) < 30
group by activity_date; 

select activity_date as day, count(distinct user_id) as active_users
from Activity
where activity_date between DATE_SUB('2019-07-27', INTERVAL 29 DAY) and '2019-07-27'
group by activity_date;