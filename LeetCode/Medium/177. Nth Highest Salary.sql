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
          limit N, 1  /*LIMIT , 1 is equivalent to LIMIT 1 OFFSET N*/
   );
END

