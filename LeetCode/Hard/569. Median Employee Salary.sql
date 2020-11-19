WITH t1 AS
( SELECT *,
         ROW_NUMBER() OVER (PARTITION BY COMPANY ORDER BY Salary) AS row_num,
         COUNT(Id) OVER (PARTITION BY COMPANY) AS cnt
  FROM Employee)
 
SELECT Id,
       Company,
       Salary
FROM t1
WHERE row_num between cnt/2 and cnt/2+1
/*WHERE row_num IN (floor((cnt+1)/2), ceil((cnt+1)/2))*/


/*

t1

{"headers": ["Id", "Company", "Salary", "num", "cnt"], 
 "values": [[3, "A", 15, 1, 6], 
            [2, "A", 341, 2, 6], 
            [5, "A", 451, 3, 6], 
            [6, "A", 513, 4, 6], 
            [1, "A", 2341, 5, 6], 
            [4, "A", 15314, 6, 6], 
            [8, "B", 13, 1, 6], 
            [7, "B", 15, 2, 6], 
            [12, "B", 234, 3, 6], 
            [9, "B", 1154, 4, 6], 
            [11, "B", 1221, 5, 6], 
            [10, "B", 1345, 6, 6], 
            [17, "C", 65, 1, 5], 
            [13, "C", 2345, 2, 5], 
            [14, "C", 2645, 3, 5], 
            [15, "C", 2645, 4, 5], 
            [16, "C", 2652, 5, 5]]}


*/
      

