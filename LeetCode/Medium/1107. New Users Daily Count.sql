SELECT login_date, COUNT(user_id) AS user_count
FROM (SELECT user_id, MIN(activity_date) AS login_date
      FROM Traffic
      WHERE activity = 'login'
      GROUP BY user_id) t
WHERE login_date BETWEEN  DATE_SUB('2019-06-30', INTERVAL 90 DAY) AND '2019-06-30' 
GROUP BY 1