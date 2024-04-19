/*************************************************************官方答案*****************************************************************************/

SELECT 
    DISTINCT a.*
FROM 
    stadium AS a, stadium AS b, stadium AS c
WHERE
     a.people >= 100 AND b.people >= 100 AND c.people >= 100
AND 
    (
       (a.id - b.id = 1 AND b.id - c.id = 1)
    OR (c.id - b.id = 1 AND b.id - a.id = 1) /*When a.id is the minimum id in the three consecutive ids (c.id > b.id > a.id)*/
    OR (b.id - a.id = 1 AND a.id - c.id = 1) /*When a.id is in the middle of the three consecutive ids (b.id > a.id > c.id)*/
    )
ORDER BY visit_date
	
/*-------------------------------------------------------------------------------------*/


	
WITH base AS (
        SELECT *,
            LEAD(id, 1) OVER(ORDER BY id) AS next_id,
            LEAD(id, 2) OVER(ORDER BY id) AS second_next_id,
            LAG(id, 1) OVER(ORDER BY id) AS last_id,
            LAG(id, 2) OVER(ORDER BY id) AS second_last_id
        FROM stadium
        WHERE people >= 100 
        )
SELECT DISTINCT id, visit_date, people
FROM base 
WHERE (next_id - id = 1 AND id - last_id = 1)
    OR (second_next_id - next_id = 1 AND next_id - id = 1)
    OR (id - last_id = 1 AND last_id - second_last_id = 1)
ORDER BY visit_date

| id | visit_date | people | next_id | second_next_id | last_id | second_last_id |
| -- | ---------- | ------ | ------- | -------------- | ------- | -------------- |
| 2  | 2017-01-02 | 109    | 3       | 5              | null    | null           |
| 3  | 2017-01-03 | 150    | 5       | 6              | 2       | null           |
| 5  | 2017-01-05 | 145    | 6       | 7              | 3       | 2              |
| 6  | 2017-01-06 | 1455   | 7       | 8              | 5       | 3              |
| 7  | 2017-01-07 | 199    | 8       | null           | 6       | 5              |
| 8  | 2017-01-09 | 188    | null    | null           | 7       | 6              |

/*-------------------------------------------------------------------------------------*/
	
	
WITH stadium_with_rnk AS
(
    SELECT id, visit_date, people, rnk, (id - rnk) AS island
    FROM (
        SELECT id, visit_date, people, RANK() OVER(ORDER BY id) AS rnk
        FROM Stadium
        WHERE people >= 100) AS t0
)
SELECT id, visit_date, people 
FROM stadium_with_rnk
WHERE island IN (SELECT island 
                 FROM stadium_with_rnk 
                 GROUP BY island 
                 HAVING COUNT(*) >= 3)
ORDER BY visit_date

| id | visit_date | people | rnk | island |
| -- | ---------- | ------ | --- | ------ |
| 2  | 2017-01-02 | 109    | 1   | 1      |
| 3  | 2017-01-03 | 150    | 2   | 1      |
| 5  | 2017-01-05 | 145    | 3   | 2      |
| 6  | 2017-01-06 | 1455   | 4   | 2      |
| 7  | 2017-01-07 | 199    | 5   | 2      |
| 8  | 2017-01-09 | 188    | 6   | 2      |
/******************************************************************************************************************************************/
select distinct t1.*
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and
(
    (t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1)  -- t1, t2, t3
    or
    (t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) -- t2, t1, t3
    or
    (t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2) -- t3, t2, t1
)
order by t1.id
;
/*-------------------------------------------------------------------------------------*/

SELECT *
FROM Stadium
WHERE id IN (SELECT id
             FROM (SELECT id, COUNT(*) OVER (PARTITION BY DIFF) as cnt
                   FROM (SELECT id, id - ROW_NUMBER() over (ORDER BY id) AS diff
                         FROM Stadium
                         WHERE people >= 100) a
                   ) b
             WHERE cnt >= 3);

| id | ROW_NUMBER() over (ORDER BY id) | diff |
| -- | ------------------------------- | ---- |
| 2  | 1                               | 1    |
| 3  | 2                               | 1    |
| 5  | 3                               | 2    |
| 6  | 4                               | 2    |
| 7  | 5                               | 2    |
| 8  | 6                               | 2    |

| id | cnt |
| -- | --- |
| 2  | 2   |
| 3  | 2   |
| 5  | 4   |
| 6  | 4   |
| 7  | 4   |
| 8  | 4   |
/*-------------------------------------------------------------------------------------*/
			 
SELECT ID
    , visit_date
    , people
FROM (
    SELECT ID
        , visit_date
        , people
        , LEAD(people, 1) OVER (ORDER BY id) nxt
        , LEAD(people, 2) OVER (ORDER BY id) nxt2
        , LAG(people, 1) OVER (ORDER BY id) pre
        , LAG(people, 2) OVER (ORDER BY id) pre2
    FROM Stadium
) cte 
WHERE (cte.people >= 100 AND cte.nxt >= 100 AND cte.nxt2 >= 100) 
    OR (cte.people >= 100 AND cte.nxt >= 100 AND cte.pre >= 100)  
    OR (cte.people >= 100 AND cte.pre >= 100 AND cte.pre2 >= 100) 	
	
/*-------------------------------------------------------------------------------------*/
with t1 as
(select id, 
        visit_date, 
        people,
        lead(people, 1) over (order by id) as p_nextid,
        lead(people, 2) over (order by id) as p_2nextid ,
        lag(people, 1) over (order by id) as p_previd,
        lag(people, 2) over (order by id) as p_2previd
from stadium
)

select id, 
       visit_date, 
       people
from t1
where (people >= 100 and p_nextid >= 100 and p_2nextid >= 100) 
   or (people >= 100 and p_previd >= 100 and p_2previd >= 100) 
   or (people >= 100 and p_previd >= 100 and p_nextid >= 100)

| id | visit_date | people | p_nextid | p_2nextid | p_previd | p_2previd |
| -- | ---------- | ------ | -------- | --------- | -------- | --------- |
| 1  | 2017-01-01 | 10     | 109      | 150       | null     | null      |
| 2  | 2017-01-02 | 109    | 150      | 99        | 10       | null      |
| 3  | 2017-01-03 | 150    | 99       | 145       | 109      | 10        |
| 4  | 2017-01-04 | 99     | 145      | 1455      | 150      | 109       |
| 5  | 2017-01-05 | 145    | 1455     | 199       | 99       | 150       |
| 6  | 2017-01-06 | 1455   | 199      | 188       | 145      | 99        |
| 7  | 2017-01-07 | 199    | 188      | null      | 1455     | 145       |
| 8  | 2017-01-09 | 188    | null     | null      | 199      | 1455      |
