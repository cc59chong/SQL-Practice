CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN( SELECT 
              DISTINCT Salary
		  FROM (SELECT
		            Id,
					Salary,
					DENSE_RANK() OVER (
					    ORDER BY Salary DESC
					) AS 'Rank'
				FROM 
				   Employee
				) e
		  WHERE N = e.RANK 
  );
END

/*--------------------------------------------------------*/
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N-1;
RETURN ( SELECT 
             DISTINCT salary
         FROM Employee
         ORDER BY salary DESC
         LIMIT 1 OFFSET N
   );
END

/*----------------------------------------------------------*/
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N - 1;
   RETURN(SELECT 
               DISTINCT Salary
          FROM  Employee
          ORDER BY Salary DESC
          LIMIT N, 1  
   );

END

LIMIT 1 OFFSET N = 跳过前 N 行，取 1 行

LIMIT N, 1 = 从第 N 行开始（0-based），取 1 行

为什么要 SET N = N-1？
这是因为 LIMIT/OFFSET 使用 0-based 索引，而题目中的 N 是 1-based。
举例说明：
想要第 1 高工资：需要跳过 0 行 → OFFSET 0
想要第 2 高工资：需要跳过 1 行 → OFFSET 1
想要第 N 高工资：需要跳过 (N-1) 行 → OFFSET N-1

