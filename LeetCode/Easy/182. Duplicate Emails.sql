SELECT DISTINCT a.Email
FROM Person a, Person b
WHERE a.Email = b.Email AND a.Id != b.Id;