SELECT s.name
FROM salesperson s
WHERE s.sales_id NOT IN (SELECT o.sales_id
                     FROM company c
                     LEFT JOIN orders o ON c.com_id = o.com_id
                     WHERE c.name = 'RED');
