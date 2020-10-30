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
