SELECT IFNULL(NULL,MAX(num)) AS num
FROM my_numbers
WHERE num IN (SELECT num
              FROM my_numbers
              GROUP BY num
              HAVING COUNT(num) <= 1);