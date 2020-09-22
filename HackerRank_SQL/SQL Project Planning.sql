SELECT Start_Date, MIN(End_Date)
FROM (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
     (SELECT End_date FROM Projects WHERE End_date NOT IN (SELECT Start_date FROM Projects)) b
WHERE Start_date < End_date
GROUP BY Start_date
ORDER BY DATEDIFF(Start_date, MIN(End_date)) DESC, Start_date;





SELECT Start_Date, MIN(End_Date)
FROM 
/* Choose start dates that are not end dates of other projects 
(if a start date is an end date, it is part of the same project) */
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
/* Choose end dates that are not end dates of other projects */
    (SELECT End_date FROM Projects WHERE End_date NOT IN (SELECT Start_date FROM Projects)) b
/* At this point, we should have a list of start dates and end dates that don't necessarily correspond with each other */
/* This makes sure we only choose end dates that fall after the start date, and choosing the MIN means for 
   the particular start_date, we get the closest end datethat does not coincide with the start of another task */
WHERE Start_date < End_date
GROUP BY Start_date
ORDER BY datediff(Start_date, MIN(End_date)) DESC, Start_date