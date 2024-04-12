SELECT name
FROM customer
WHERE referee_id != 2 OR  referee_id IS NULL

/*--------------------------------------------------------------------*/
SELECT name
FROM customer 
WHERE id NOT IN (SELECT id FROM customer WHERE referee_id = 2);