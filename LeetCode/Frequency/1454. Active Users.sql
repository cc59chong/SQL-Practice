SELECT DISTINCT a.id, 
               (SELECT name FROM Accounts WHERE id=a.id) name
FROM Logins a, Logins b
WHERE a.id=b.id 
  AND DATEDIFF(a.login_date,b.login_date) BETWEEN 1 AND 4
GROUP BY a.id, a.login_date
HAVING COUNT(DISTINCT b.login_date)=4
ORDER BY a.id;



/*
SELECT *
FROM Logins a, Logins b
WHERE a.id=b.id 
  AND DATEDIFF(a.login_date,b.login_date) BETWEEN 1 AND 4

| id | login_date | id | login_date |
| -- | ---------- | -- | ---------- |
| 7  | 2020-06-03 | 7  | 2020-05-30 |
| 7  | 2020-06-02 | 7  | 2020-05-30 |
| 7  | 2020-06-02 | 7  | 2020-05-30 |
| 7  | 2020-06-01 | 7  | 2020-05-30 |
| 7  | 2020-05-31 | 7  | 2020-05-30 |
| 7  | 2020-06-03 | 7  | 2020-05-31 |
| 7  | 2020-06-02 | 7  | 2020-05-31 |
| 7  | 2020-06-02 | 7  | 2020-05-31 |
| 7  | 2020-06-01 | 7  | 2020-05-31 |
| 7  | 2020-06-03 | 7  | 2020-06-01 |
| 7  | 2020-06-02 | 7  | 2020-06-01 |
| 7  | 2020-06-02 | 7  | 2020-06-01 |
| 7  | 2020-06-03 | 7  | 2020-06-02 |
| 7  | 2020-06-03 | 7  | 2020-06-02 |

*/

/*---------------------------------------------------------------*/
WITH t1 AS(
    select distinct * from logins),
    t2 AS(
    SELECT *,
          ROW_NUMBER() OVER(PARTITION BY id ORDER BY login_date) AS r
    FROM t1),
    t3 AS(
    SELECT *,
           DATE_SUB(login_date, INTERVAL r DAY) AS island
    FROM t2
    )

SELECT DISTINCT t3.id, a.name
FROM t3
JOIN Accounts a ON t3.id=a.id
GROUP BY t3.id, t3.island
HAVING COUNT(*) >=5
ORDER BY t3.id
