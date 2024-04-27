SELECT user_id,user_name,
IFNULL(SUM(CASE WHEN a.user_id=b.paid_by THEN -amount ELSE amount END),0)+a.credit as credit,
CASE WHEN IFNULL(SUM(CASE WHEN a.user_id=b.paid_by THEN -amount ELSE amount END),0)>=-a.credit THEN "No" ELSE "Yes" END as credit_limit_breached
FROM Users as a
LEFT JOIN Transactions as b
ON a.user_id=b.paid_by OR a.user_id=b.paid_to
GROUP BY a.user_id;

/*---------------------------------------------------------------------------------------------------------------------------------*/

SELECT DISTINCT u.user_id,
       u.user_name,
       credit - IFNULL(pya,0) + IFNULL(pda,0) AS credit,
       IF((credit - IFNULL(pya,0) + IFNULL(pda,0))<0,'Yes','No') AS credit_limit_breached      
FROM Users u
LEFT JOIN (SELECT paid_by, SUM(amount) AS pya
           FROM Transactions
           GROUP BY paid_by) py
ON u.user_id=py.paid_by
LEFT JOIN (SELECT paid_to, SUM(amount) AS pda
           FROM Transactions
           GROUP BY paid_to) pt
ON u.user_id=pt.paid_to
