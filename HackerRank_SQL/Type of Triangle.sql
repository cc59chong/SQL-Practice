SELECT CASE 
          WHEN A + B > C AND A + C > B AND B + C > A THEN 
		    CASE 
               WHEN A = B AND B = C THEN 'Equilateral'
               WHEN A = B or B = C or A = C THEN 'Isosceles'
               ELSE 'Scalene'
	        END
		  ELSE 'Not A Triangle' 
		END
FROM TRIANGLES;
