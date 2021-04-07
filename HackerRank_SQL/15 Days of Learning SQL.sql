/*
submission_date
hackerCount,submissionCount,dates used to get number of unique submissions each day
topHack - hacker_id with most submissions for each day 
dates - list unique contest dates
*/

SELECT 
    submission_date ,
   (SELECT COUNT(DISTINCT hacker_id)  
    FROM Submissions AS hackerCount  
    WHERE hackerCount.submission_date = dates.submission_date 
    AND (SELECT COUNT(DISTINCT submissionCount.submission_date) 
         FROM Submissions AS submissionCount 
         WHERE submissionCount.hacker_id = hackerCount.hacker_id 
         AND submissionCount.submission_date < dates.submission_date) = DATEDIFF(dates.submission_date , '2016-03-01')
     ) ,
   (SELECT hacker_id  
    FROM submissions hackerList 
    WHERE hackerList.submission_date = dates.submission_date 
    GROUP BY hacker_id 
    ORDER BY count(submission_id) DESC , hacker_id limit 1) AS topHack,
   (SELECT name 
    FROM hackers 
    WHERE hacker_id = topHack)
    FROM (SELECT distinct submission_date from submissions) dates
    GROUP BY submission_date