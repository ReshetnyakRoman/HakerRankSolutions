/*========Aggregation===========*/
/*
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeroes removed), and the actual average salary.
Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.*/
SELECT CEIL(AVG(E.Salary)-AVG(E2.Salary2))
FROM EMPLOYEES E, (SELECT REPLACE(Salary,0,'') AS Salary2 FROM EMPLOYEES) E2;

SELECT CEIL(AVG(Salary)-AVG(REPLACE(Salary,0,'')))
FROM EMPLOYEES;


/*We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.*/

SELECT SALARY*MONTHS, COUNT(*)
FROM Employee
GROUP BY 1
ORDER BY 1 DESC
LIMIT 1;


/*TWO WAYS OF FINDING MEDIANS*/
/*WAY 1 FOR ROW = LAT_N*/
SELECT ROUND(AVG(middle_values),4) AS 'median' 
FROM (
      SELECT t1.LAT_N AS 'middle_values' 
      FROM (
	          SELECT @row:=@row+1 as `row`, x.LAT_N
	          FROM STATION AS x, (SELECT @row:=0) AS r
	          ORDER BY x.LAT_N
	        ) AS t1,
	        (
	          SELECT COUNT(*) as 'count'
	          FROM STATION x
	        ) AS t2
        -- the following condition will return 1 record for odd number sets, or 2 records for even number sets.
        WHERE t1.row >= t2.count/2 and t1.row <= ((t2.count/2) +1)
    ) AS t3;

/*WAY 2 FOR ROW = LAT_N*/
SELECT ROUND(x.LAT_N,4)
from STATION x, STATION y
GROUP BY x.LAT_N
HAVING SUM(SIGN(1-SIGN(y.LAT_N-x.LAT_N)))/COUNT(*) > .5
LIMIT 1