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

/*Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.*/
SET @max := (SELECT count(challenge_id) as total FROM Challenges GROUP BY hacker_id ORDER BY total DESC limit 1);

SELECT c.hacker_id as id, h.name AS name, count(challenge_id) as total
FROM Hackers h JOIN Challenges c  ON h.hacker_id = c.hacker_id
GROUP BY id, name
HAVING total = @max
        OR
        total IN (SELECT total
                    FROM (
                        SELECT count(challenge_id) as total
                        FROM Hackers h join Challenges c  on h.hacker_id = c.hacker_id
                        GROUP BY h.hacker_id, h.name) as t1
                    GROUP BY total
                    HAVING count(total) = 1 )
ORDER BY total DESC, id;