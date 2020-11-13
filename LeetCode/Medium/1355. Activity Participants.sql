WITH a as
(SELECT 
       activity,
       COUNT(id) OVER (PARTITION BY activity) cnt
 FROM 
      Friends) 

SELECT DISTINCT activity
FROM a
WHERE cnt NOT IN (SELECT MAX(cnt) FROM a)
  AND cnt NOT IN (SELECT MIN(cnt) FROM a)
  
/*-------------------------------------------------------------------------------------*/
 
 select activity
from
(select activity,
        rank()over( order by count(id) )as cnt_asc,
        rank()over(order by count(id) desc) as cnt_desc
 from Friends
 group by activity) t
where cnt_asc != 1 and cnt_desc != 1

/*-------------------------------------------------------------------------------------*/
  
select activity 
from friends
group by activity
having count(*)> (select count(*) from friends group by activity order by 1 limit 1)
and count(*)< (select count(*) from friends group by activity order by 1 desc limit 1)