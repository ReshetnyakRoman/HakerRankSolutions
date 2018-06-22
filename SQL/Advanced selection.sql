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










