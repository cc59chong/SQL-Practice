SELECT DISTINCT a.id, 
               (SELECT name FROM Accounts WHERE id=a.id) name
FROM Logins a, Logins b
WHERE a.id=b.id 
  AND DATEDIFF(a.login_date,b.login_date) BETWEEN 1 AND 4
GROUP BY a.id, a.login_date
HAVING COUNT(DISTINCT b.login_date)=4;

/*
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

/*-----------------------------------------------------------------------------------------*/

with gaps_and_islands as(
select
id, login_date,
dense_rank() over (partition by id order by login_date) as rnk
from (select distinct id, login_date from logins) a),

filled_gaps as (
select id, login_date, rnk, 
date_add(login_date, interval - rnk day) as nw_date
from gaps_and_islands )


select distinct a.id, name
from
(select id
from filled_gaps
group by id, nw_date
having count(*) >= 5)a
left join accounts b
on a.id = b.id

  

/*-----------------------------------------------------------------------------------------

1. 
select
id, login_date,
dense_rank() over (partition by id order by login_date) as rnk
from (select distinct id, login_date from logins) a

| id | login_date | rnk |
| -- | ---------- | --- |
| 1  | 2020-05-30 | 1   |
| 1  | 2020-06-07 | 2   |
| 7  | 2020-05-30 | 1   |
| 7  | 2020-05-31 | 2   |
| 7  | 2020-06-01 | 3   |
| 7  | 2020-06-02 | 4   |
| 7  | 2020-06-03 | 5   |
| 7  | 2020-06-10 | 6   |

2.  
select id, login_date, rnk, 
       date_add(login_date, interval - rnk day) as nw_date
from gaps_and_islands 

| id | login_date | rnk | nw_date    |
| -- | ---------- | --- | ---------- |
| 1  | 2020-05-30 | 1   | 2020-05-29 |
| 1  | 2020-06-07 | 2   | 2020-06-05 |
| 7  | 2020-05-30 | 1   | 2020-05-29 |
| 7  | 2020-05-31 | 2   | 2020-05-29 |
| 7  | 2020-06-01 | 3   | 2020-05-29 |
| 7  | 2020-06-02 | 4   | 2020-05-29 |
| 7  | 2020-06-03 | 5   | 2020-05-29 |
| 7  | 2020-06-10 | 6   | 2020-06-04 |

*/
