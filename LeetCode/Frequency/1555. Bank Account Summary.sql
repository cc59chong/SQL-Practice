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