SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;

/*---------------------------------------------------------------------------------------*/
SELECT distinct num ConsecutiveNums
FROM
(SELECT id, num,
        LAG(num) over (order by id) as pre,
        lead(num) over (order by id) as nxt
 FROM logs) next_prev
WHERE num=pre and pre =nxt

/*---------------------------------------------------------------------------------------*/

select distinct Num as ConsecutiveNums
from Logs
where (Id + 1, Num) in (select * from Logs) and (Id + 2, Num) in (select * from Logs)
/*
{"headers": ["Id + 1", "Num"], 
 "values": [[2, 1], [3, 1], [4, 1], [5, 2], [6, 1], [7, 2], [8, 2]]}

IN select * from Logs : [2, 1], [3, 1], [7, 2]

{"headers": ["Id + 2", "Num"], 
 "values": [[3, 1], [4, 1], [5, 1], [6, 2], [7, 1], [8, 2], [9, 2]]}

IN select * from Logs : [3, 1], [5, 1], [6, 2]

AND 
[3, 1]
*/

/*---------------------------------------------------------------------------------------*/
select distinct num as consecutiveNums
from (select num,
             sum(c) over (order by id) as flag 
      from (select id, num, case when LAG(Num) OVER (order by id)- Num = 0 then 0 else 1 end as c
            from logs) a) b
group by num,flag
having count(*) >=3

/*
the first subquery A: select id, num, case when LAG(Num) OVER (order by id)- Num = 0 then 0 else 1 end as c from logs
LAG(Num) OVER (order by id) allows us to read the previous row's Num value. The case statement is setting c to 1 anytime the previous Num does not match the current Num, otherwise sets it to 0.

This returns:

[1,1,1],
[2,1,0],
[3,1,0],
[4,2,1],
[5,1,1],
[6,2,1],
[7,2,0]
The second subquery B: select num,sum(c) over (order by id) as flag from A
This is the clever bit, by using the c value from before in conjunction with sum, flag is actually just a rolling sum of the c column up to that row by the id. So the results look like so:

[1,1],
[1,1],
[1,1],
[2,2],
[1,3],
[2,4],
[2,4]
So we get back a number and the "flag" (which is the rolling sum) up to that row.

Now the meat of the outer query:

group by num,flag
having count(*) >=3
This part becomes intuitive, group the tuples (number, flag/rolling sum), and only return the numbers with more than 3 rows.
*/