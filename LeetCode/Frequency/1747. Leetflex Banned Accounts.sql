
SELECT DISTINCT l1.account_id
FROM LogInfo l1, LogInfo l2
WHERE l1.account_id=l2.account_id 
      AND l1.ip_address!=l2.ip_address 
      -- AND DATE(l1.login)=DATE(l2.login)
      AND (l2.login BETWEEN l1.login AND l1.logout)

/*-------------------------------------------------------*/

SELECT
  DISTINCT l1.account_id
FROM
  LogInfo l1
CROSS JOIN
  LogInfo l2
WHERE
  l1.account_id = l2.account_id AND
  l1.ip_address != l2.ip_address AND
  l1.login <= l2.logout AND l2.login <= l1.logout

速度1>2

SELECT DISTINCT l1.account_id
FROM LogInfo l1, LogInfo l2
WHERE l1.account_id=l2.account_id
   AND l1.ip_address!=l2.ip_address
   AND l2.login<=l1.logout
   AND l1.login<=l2.logout
