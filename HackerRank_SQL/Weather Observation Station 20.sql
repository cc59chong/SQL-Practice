SELECT ROUND(S1.LAT_N, 4) 
FROM STATION AS S1 
WHERE (SELECT ROUND(COUNT(S1.ID)/2) - 1 
       FROM STATION) = 
      (SELECT COUNT(S2.ID) 
       FROM STATION AS S2 
       WHERE S2.LAT_N > S1.LAT_N);
	   
	   
SET @rowIndex := -1;
SELECT ROUND(AVG(t.LAT_N), 4) FROM
(
SELECT @rowIndex := @rowIndex+1 AS rowIndex, s.LAT_N FROM STATION AS s ORDER BY s.LAT_N
) AS t
WHERE t.rowIndex IN (FLOOR(@rowIndex / 2), CEIL(@rowIndex / 2));
/*
https://nifannn.github.io/2017/10/23/SQL-Notes-Hackerrank-Weather-Observation-Station-20/
*/

/*
median(x) = 1/2(x * floor【(n+1）/2】 + x * ceil[(n+1）/2])

mysql中变量不用事前申明，在用的时候直接用“@变量名”使用就可以了。
第一种用法：set @num=1; 或set @num:=1; //这里要使用变量来保存数据，直接使用@num变量
第二种用法：select @num:=1; 或 select @num:=字段名 from 表名 where ……
注意上面两种赋值符号，使用set时可以用“=”或“：=”，但是使用select时必须用“：=赋值”

*/