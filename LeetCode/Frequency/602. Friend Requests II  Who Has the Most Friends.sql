select id1 as id, count(id2) as num
from
(select requester_id as id1, accepter_id as id2 
from RequestAccepted
union all
select accepter_id as id1, requester_id as id2 
from RequestAccepted) tmp1
group by id1 
order by num desc limit 1


/*-------------------------------------------------------------*/

WITH t AS(
SELECT requester_id AS id, COUNT(*) cnt
FROM RequestAccepted 
GROUP BY 1
UNION ALL
SELECT accepter_id AS id, COUNT(*) cnt
FROM RequestAccepted 
GROUP BY 1)

SELECT id, SUM(cnt) AS num 
FROM t
GROUP BY id
ORDER BY num DESC
LIMIT 1
