SELECT a.Name AS Employee
FROM Employee a
JOIN Employee b ON a.ManagerId = b.Id
WHERE a.Salary > b.Salary;

/*

SELECT *
FROM Employee a
JOIN Employee b ON b.ManagerId = a.Id


{"headers": ["Id", "Name", "Salary", "ManagerId", "Id", "Name", "Salary", "ManagerId"], 
 "values": [  [3,  "Sam",   60000,    null,        1,   "Joe",   70000,    3], 
              [4,  "Max",   90000,    null,        2,   "Henry", 80000,    4]]}


*/