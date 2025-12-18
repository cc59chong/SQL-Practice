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
