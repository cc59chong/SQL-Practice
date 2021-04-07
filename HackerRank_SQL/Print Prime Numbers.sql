SET @potential_prime = 1;
SET @divisor = 1;

SELECT GROUP_CONCAT(POTENTIAL_PRIME SEPARATOR '&') FROM
    (SELECT @potential_prime := @potential_prime + 1 AS POTENTIAL_PRIME FROM
    information_schema.tables t1,
    information_schema.tables t2
    LIMIT 1000) list_of_potential_primes
WHERE NOT EXISTS(
	SELECT * FROM
        (SELECT @divisor := @divisor + 1 AS DIVISOR FROM
	    information_schema.tables t4,
        information_schema.tables t5
	    LIMIT 1000) list_of_divisors
	WHERE MOD(POTENTIAL_PRIME, DIVISOR) = 0 AND POTENTIAL_PRIME <> DIVISOR);

/*
Explanation:

1) The two inner SELECTs (SELECT @potential_prime and SELECT @divisor) create two lists. 
Both of them contain numbers from 1 to 1000. The first list is list_of_potential_primes 
and the second is list_of_divisors.

2) Then, we iterate over the list of the potential primes (the outer SELECT) 
and for each number from this list we look for divisors (SELECT * FROM clause) 
that can divide the number without a reminder and are not equal to the number (WHERE MOD... clause).
 If at least one such divisor exists, the number is not prime and is not selected (WHERE NOT EXISTS... clause).

The SELECT statement witn information_schema.tables t1 is a trick that is used to generate a table 
with one row of numbers from 1 to 1000. 
It seems to be the only effective way to do it in MySQL. information_schema.tables is just a system table 
that is guaranteed to exist in any MySQL database and that has enough rows, 
so when you join it with itself (FROM information_schema.tables t1, information_schema.tables t2) 
you get a table with more than 1000 rows. Then, the SELECT statement iterates over this table and, 
with each iteration, increments the counter @potential_prime. This way, you get that row of numbers from 1 to 1000.

Group_CONCAT() Function
https://www.geeksforgeeks.org/mysql-group_concat-function/

*/