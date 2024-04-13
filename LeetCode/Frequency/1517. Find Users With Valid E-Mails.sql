SELECT *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_\.\-]*@leetcode(\\?com)?\\.com$'




/*
SELECT *
FROM Users
WHERE mail REGEXP '^[a-z][a-z0-9._-]*@leetcode.com$';
*/

/*
SELECT *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9\_\.\-]*@leetcode\.com$'
*/



/*
^[A-Za-z] the first character must be a letter. after that...
[A-Za-z0-9_.-]* match any number of letters, numbers, underscore, periods, dashes 
(the * sign indicating "any number of, including zero"). after that...
@leetcode.com$ the email must end with exactly "@leetcode.com" (the $ sign indicating "ending with")

Note that the escape characters are not strictly necessary. 
This means that the backslash ( \ ) symbol that precedes the period, dash, etc is not needed here. 
I've left them in because it's what I'm accustomed to. I don't know why exactly MySQL does not require them, but so it is.

Also note that, since SQL is not case sensitive generally, 
it's also not necessary to include both uppercase and lowercase letters 
(ie one could just as easily use [A-Z] instead of [A-Za-z].
 Again, I've included them because outside of SQL that would be necessary.
 */
