SELECT *
FROM Patients
WHERE conditions REGEXP '\\bDIAB1'

/*The reason they are the same is that \b matches either a non-word character (in our case, a space) or the position before the first character in the string. 
  Also, you need to escape a backslash with another backslash, like so: \\b. Otherwise, the regular expression won't evaluate.*/

/*----------------------------------------------*/

SELECT *
FROM Patients
WHERE conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%';

/*
conditions LIKE 'DIAB1%': This condition matches rows where the 'conditions' column starts with the string 'DIAB1'. 
The % wildcard is used to match any sequence of characters after 'DIAB1'. 
So, this part of the condition will match rows where 'conditions' is exactly 'DIAB1' or starts with 'DIAB1' followed by any characters.

conditions LIKE '% DIAB1%': This condition matches rows where the 'conditions' column contains the string ' DIAB1'. 
The % wildcard at the beginning allows for any characters before ' DIAB1', and the % wildcard at the end allows for any characters after ' DIAB1'. 
This part of the condition will match rows where 'conditions' contains ' DIAB1' as a separate word, with spaces before and after it.*/
