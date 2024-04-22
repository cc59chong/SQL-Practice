DELETE FROM Person
WHERE Id NOT IN (SELECT MIN(Id) 
                 FROM (SELECT * FROM Person) AS a
                 GROUP BY Email);


DELETE p1 FROM Person p1, Person p2
WHERE p1.Email = p2.Email AND p1.Id > P2.Id;

速度 1>2
