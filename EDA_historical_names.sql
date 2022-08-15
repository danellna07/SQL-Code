--Initital look at number of names
SELECT first_name, SUM(num)
FROM baby_names
GROUP BY first_name
HAVING COUNt(year) = 101
 ORDER BY SUM(num) DEsc;
 
 --Popularity of names
 SELECT first_name, SUM(num),
CASE
    WHEN COUNT(year) > 20 THEN 'Semi-trendy'
    WHEN COUNT(year) > 50 THEN 'Semi-classic'
    WHEN COUNT(year) > 80 THEN 'Classic'
    ELSE 'Trendy' END AS popularity_type
FROM baby_names
GROUP BY first_name
ORDER BY first_name;

--Top ranked since 1920 
SELECT 
    RANK() OVER (ORDER BY SUM(num) DESC) AS name_rank, first_name, SUM(num)
FROM baby_names
WHERE sex = 'F'
GROUP BY first_name
LIMIT 10;

--When did this particular name become popular?
SELECT year, first_name, num, SUM(num) OVER (ORDER BY year) aS cumulative_olivias
FROM baby_names
WHERE first_name = 'Olivia'
ORDER BY year;

-- Top male names for each year
SELECT b.year, b.first_name, b.num
FROM baby_names AS b
INNER JOIN(
SELECT year, MAX(num) AS max_num
FROM baby_names
WHERE sex = 'M'
GROUP BY year) as subquery
On subquery.year = b.year AND subquery.max_num = b.num
ORDER BY year DESC;

--Number one name for largest number of years
WITH top_male_names AS (
    SELECT b.year, b.first_name, b.num
    FROM baby_names AS b
    INNER JOIN (
        SELECT year, MAX(num) num
        FROM baby_names
        WHERE sex = 'M'
        GROUP BY year) AS subquery 
    ON subquery.year = b.year 
        AND subquery.num = b.num
    ORDER BY YEAR DESC
    )
SELECT first_name, COUNT(first_name) as count_top_name
FROM top_male_names
GROUP BY first_name
ORDER BY COUNT(first_name) DESC;
