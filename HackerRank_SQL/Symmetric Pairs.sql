SELECT f1.X, f1.Y
FROM Functions f1, Functions f2
WHERE f1.X = f2.Y AND f2.X = f1.Y
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X) > 1 OR f1.X < f1.Y
ORDER BY f1.X

/*The key is the HAVING line, with two conditions.

The first condition in that line makes sure pairs with the same X and Y values
don't get to count themselves as their symmetric pair. 
(e.g. if 10 10 appears one time it's not counted as a symmetric pair, 
but as 13 13 appears twice, that is a symmetric pair)

The second condition ensures that only one of a pair is displayed. 
(e.g. if 3 24 and 24 3 form a symmetric pair, it will only display 3 24, not 24 3 as well.)

*/