
SELECT IFNULL(MAX(num),NULL) AS num
FROM
(SELECT num
FROM MyNumbers
GROUP BY num
HAVING COUNT(*) =1) t

/*-------------------------------------------------*/


SELECT IFNULL(NULL,MAX(num)) AS num
FROM my_numbers
WHERE num IN (SELECT num
              FROM my_numbers
              GROUP BY num
              HAVING COUNT(num) <= 1);

/*-------------------------------------------------*/

SELECT IFNULL(
    (SELECT DISTINCT num
     FROM MyNumbers
     GROUP BY num
     HAVING COUNT(num)=1
     ORDER BY num DESC
     LIMIT 1),NULL) AS num
