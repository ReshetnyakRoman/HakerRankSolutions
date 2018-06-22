/*Placements*/
/*You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).*/

SELECT name
FROM (
    SELECT s.id AS id, s.name AS name, 
           p.salary as salary, f.friend_id as fid, 
           p2.salary as Fsalary
    FROM (((Students s JOIN Packages p ON s.id = p.id) 
          JOIN Friends f ON s.id = f.id) 
          JOIN Packages p2 ON f.friend_id = p2.id)
) AS t1
WHERE fsalary > salary
ORDER BY fsalary;

/*Symmetric Pairs*/
/*You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X.*/
select f1.x as x, f1.y as y from functions f1
    where f1.x in (select f2.y from functions f2 where f2.y = f1.x and f2.y!=f2.x) 
    and f1.x < f1.y 

union all

select f3.x as x, f3.y as y  from functions f3
    where f3.x=f3.y
    group by x
    having count(x)>1
order by x


/*Projects*/
/*You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.
*/
SELECT Start_date, min(End_date)
FROM (SELECT Start_date FROM Projects WHERE Start_date NOT IN (SELECT End_Date FROM Projects)) a,
     (SELECT End_date FROM Projects WHERE End_date NOT IN (SELECT Start_date FROM Projects)) b
WHERE End_date > Start_date
GROUP BY Start_date
ORDER BY DATEDIFF(min(End_date),Start_date),Start_date


/*Interviews (HARD)*/
/*Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .
Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.*/
SELECT  c.contest_id, 
        c.hacker_id, 
        c.name,
        sum(s.total_submissions) as ts,
        sum(s.total_accepted_submissions) as tas, 
        sum(v.total_views) as tv,
        sum(v.total_unique_views) as tuv 

FROM ((((Contests c JOIN Colleges co ON c.contest_id = co.contest_id)
      JOIN Challenges ch ON co.college_id = ch.college_id) 
      
      LEFT JOIN (SELECT challenge_id as challenge_id, 
                        sum(total_submissions) as total_submissions, 
                        sum(total_accepted_submissions) as total_accepted_submissions 
                 FROM Submission_Stats
                 GROUP BY challenge_id) s ON s.challenge_id = ch.challenge_id)
      
      LEFT JOIN (SELECT challenge_id as challenge_id, 
                        sum(total_views) as total_views, 
                        sum(total_unique_views) as total_unique_views 
                 FROM View_Stats
                 GROUP BY challenge_id) v ON v.challenge_id = ch.challenge_id)

GROUP BY c.contest_id, c.hacker_id, c.name
HAVING ts+tv+tas+tuv>0
ORDER BY c.contest_id