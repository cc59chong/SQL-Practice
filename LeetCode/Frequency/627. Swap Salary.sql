
/*
UPDATE salary
SET sex = (CASE WHEN sex = 'm' THEN  'f' ELSE 'm' END);
*/

UPDATE salary
SET sex = IF(sex = 'm', 'f', 'm');