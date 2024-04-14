SELECT tweet_id
FROM Tweets
WHERE CHAR_LENGTH(content) > 15

SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) >15
