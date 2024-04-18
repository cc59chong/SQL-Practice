SELECT id,
       CASE WHEN P_id is NULL THEN 'Root'
            WHEN id IN (SELECT DISTINCT P_id FROM tree) THEN 'Inner'
            ELSE 'Leaf'
       END AS Type
FROM tree
ORDER BY id