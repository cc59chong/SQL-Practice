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