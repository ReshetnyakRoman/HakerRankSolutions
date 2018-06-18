/* Query the names of all American cities in CITY with populations larger than 120000. The CountryCode for America is USA. */

SELECT NAME
FROM CITY 
WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA';

/* Query a list of CITY names from STATION with even ID numbers only. You may print the results in any order, but must exclude duplicates from your answer. */

SELECT DISTINCT CITY 
FROM STATION
WHERE ID % 2 = 0
ORDER BY CITY ASC; 

/*Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table*/
SELECT COUNT(CITY)-COUNT(DISTINCT CITY) FROM STATION;

/*Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.*/
SELECT CITY, CHAR_LENGTH(CITY)
FROM STATION
ORDER BY CHAR_LENGTH(CITY), CITY LIMIT 1; 
SELECT CITY, CHAR_LENGTH(CITY)
FROM STATION
ORDER BY CHAR_LENGTH(CITY) DESC, CITY DESC
LIMIT 1;


/*Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.*/
/*oracle*/
SELECT DISTINCT CITY FROM STATION WHERE REGEXP_LIKE(LOWER(CITY), '^[aeiou]') ;

/*my sql*/
SELECT DISTINCT CITY FROM STATION WHERE CITY REGEXP "^[aeiou]";

/*Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.*/
SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3),ID;
/*ORACLE*/
select name from students WHERE marks > 75 order by substr(name,-3), ID ASC;

/*Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to decimal places.*/
SELECT ROUND(MAX(LAT_N),4) FROM STATION WHERE LAT_N < 137.2345;

/*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.*/
SELECT ROUND(LONG_W,4) FROM STATION WHERE LAT_N < 137.2345 ORDER BY LAT_N DESC LIMIT 1;

/*
Consider  and  to be two points on a 2D plane.

 happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.

*/
SELECT ROUND(ABS(MIN(LAT_N)-MAX(LAT_N)) + ABS(MIN(LONG_W)-MAX(LONG_W)),4)
FROM STATION;

/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
SELECT IF(A = B AND B = C, 'Equilateral', 
          IF(A = B AND A+B>C OR B = C AND B+C>A OR A = C AND A+C>B , 'Isosceles',
            IF(A+B<=C OR A+C<=B OR B+C<=A,'Not A Triangle','Scalene')))
FROM TRIANGLES;


/*Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:*/
SELECT CONCAT(NAME,'(',MID(OCCUPATION,1,1),')')
FROM OCCUPATIONS
ORDER BY NAME;

SELECT CONCAT('There are a total of ', COUNT(OCCUPATION), ' ' ,LOWER(OCCUPATION),'s.') AS TOTAL
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY TOTAL;


/*Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.*/

SET @r1 = 0, @r2 = 0, @r3 = 0, @r4 = 0;
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM (SELECT case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
        case when Occupation='Doctor' then Name end as Doctor,
        case when Occupation='Professor' then Name end as Professor,
        case when Occupation='Singer' then Name end as Singer,
        case when Occupation='Actor' then Name end as Actor
        FROM OCCUPATIONS
        ORDER BY Name) HELPTABLE
GROUP BY RowNumber;


/*
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.*/

/*Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. 
Order your output by ascending company_code*/

SELECT N, 
    CASE WHEN P IS NULL THEN 'Root'
         WHEN N IN (SELECT P FROM BST) THEN 'Inner'
         ELSE 'Leaf'
    END
FROM BST
ORDER BY N;

SELECT C.COMPANY_CODE, C.FOUNDER, COUNT(DISTINCT E.LEAD_MANAGER_CODE),
                                COUNT(DISTINCT E.SENIOR_MANAGER_CODE),
                                COUNT(DISTINCT E.MANAGER_CODE),
                                COUNT(DISTINCT E.EMPLOYEE_CODE)
FROM COMPANY C, EMPLOYEE E
WHERE C.COMPANY_CODE = E.COMPANY_CODE
GROUP BY C.COMPANY_CODE, C.FOUNDER
ORDER BY C.COMPANY_CODE;

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

/*========Join===========*/

/*Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.*/
SELECT CI.NAME
FROM CITY CI, COUNTRY CO
WHERE CI.COUNTRYCODE = CO.CODE AND CO.CONTINENT = 'Africa';


/*Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.*/
SELECT CO.CONTINENT, FLOOR(AVG(CI.POPULATION))
FROM COUNTRY CO, CITY CI
WHERE CI.COUNTRYCODE = CO.CODE
GROUP BY CO.CONTINENT;


SELECT CASE WHEN G.GRADE>7 THEN T1.NAME
            ELSE 'NULL'
            END AS NAMEX,
            G.GRADE, T1.MARKS
FROM GRADES G,  (SELECT NAME, MARKS, FLOOR(MARKS/10)*10 AS 'MARK_DOWN' FROM STUDENTS) T1
WHERE G.MIN_MARK = T1.MARK_DOWN
ORDER BY G.GRADE DESC, NAMEX;

/* Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.*/
SELECT CASE WHEN G.GRADE>7 THEN T1.NAME
            ELSE 'NULL'
            END AS NAMEX,
            G.GRADE, T1.MARKS
            
FROM GRADES G,  (SELECT NAME, MARKS, TRUNCATE(MARKS/10,0)*10 AS 'MARK_ROUND' FROM STUDENTS) T1
WHERE G.MIN_MARK = T1.MARK_ROUND OR G.MAX_MARK = T1.MARK_ROUND
ORDER BY G.GRADE DESC, NAMEX, T1.MARKS;

/*anoter variant*/
SELECT (CASE g.grade>=8 WHEN TRUE THEN s.name 
        ELSE null END), 
        g.grade, s.marks 
FROM students s INNER JOIN grades g ON s.marks BETWEEN min_mark AND max_mark 
ORDER BY g.grade DESC,s.name,s.marks;



/*Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.*/
select t2.haker_id, t2.name

from (
        select t1.haker_id as 'haker_id', 
               t1.name as 'name', 
               sum(t1.counter) as 'number_of_chall'
        
        from (
                select case when d.score = s.score then 1 else 0 end as 'counter',
                        s.hacker_id as 'haker_id', 
                        h.name as 'name', 
                        s.challenge_id, 
                        c.difficulty_level, 
                        d.score as 'max_score', s.score  

                from Submissions s, Hackers h, Difficulty d, Challenges c

                where s.hacker_id = h.hacker_id 
                    and c.difficulty_level = d.difficulty_level 
                    and s.challenge_id = c.challenge_id
        ) as t1
        
        group by t1.haker_id, t1.name
    
    ) as t2

where number_of_chall>1

order by t2.number_of_chall desc, t2.haker_id;

/*second variant of same problem*/
select h.hacker_id, h.name
from submissions s
inner join challenges c
on s.challenge_id = c.challenge_id
inner join difficulty d
on c.difficulty_level = d.difficulty_level 
inner join hackers h
on s.hacker_id = h.hacker_id
where s.score = d.score and c.difficulty_level = d.difficulty_level
group by h.hacker_id, h.name
having count(s.hacker_id) > 1
order by count(s.hacker_id) desc, s.hacker_id asc


/*Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.*/
select distinct w.id, p.age, w.coins_needed, w.power

from Wands w join Wands_Property p on w.code = p.code

where p.is_evil = 0 and w.coins_needed = (

    select min(coins_needed)
    from Wands w1 join Wands_Property p1 on w1.code = p1.code
    where  w.power = w1.power and p.age = p1.age
)

order by w.power desc, p.age desc;


/*The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.*/
select h.hacker_id, h.name, sum(score) as 'total_score'
from Hackers h inner join 
    (select hacker_id, max(score) as 'score' from Submissions s group by challenge_id, hacker_id) max_score 
    on h.hacker_id = max_score.hacker_id

group by h.hacker_id, h.name
having total_score > 0
order by total_score desc, h.hacker_id
