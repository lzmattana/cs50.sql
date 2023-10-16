/*
Problem to Solve
You just landed a new job as a data analyst for the State of Massachusetts, working within the Department of Elementary and Secondary Education (or DESE, for short!). 
DESE oversees the state’s public education system. One responsibility of DESE is to ensure every child has a quality education—one in which they encounter experienced teachers, 
have access to an abundance of resources, and ultimately graduate having met all requirements of the state. Your SQL skills have a part to play in these lofty goals!
In a database called dese.db, answer questions about the state of education in Massachusetts. */

-- 1 Your colleague is preparing a map of all public schools in Massachusetts. In 1.sql, write a SQL query to find the names and cities of all public schools in Massachusetts.
SELECT name, city
FROM schools
WHERE type = 'Public School';

-- 2 Your team is working on archiving old data. In 2.sql, write a SQL query to find the names of districts that are no longer operational.
SELECT name
FROM districts
WHERE name LIKE '%(non-op)';

--3 The Massachusetts Legislature would like to learn how much money, on average, districts spent per-pupil last year. In 3.sql, write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”.
SELECT AVG(per_pupil_expenditure)
AS 'Average District Per-Pupil Expenditure'
FROM expenditures;

--4 Some cities have more public schools than others. In 4.sql, write a SQL query to find the 10 cities with the most public schools. Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.
SELECT city, COUNT(*) AS num_public_schools
FROM schools
WHERE type = 'Public School'
GROUP BY city
ORDER BY num_public_schools DESC, city ASC
LIMIT 10;

--5 DESE would like you to determine in what cities additional public schools might be needed. In 5.sql, write a SQL query to find cities with 3 or fewer public schools. Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.
SELECT city, COUNT(*) AS num_public_schools
FROM schools
WHERE type = 'Public School'
GROUP BY city
HAVING num_public_schools <= 3
ORDER BY num_public_schools DESC, city ASC;

--6 DESE wants to assess which schools achieved a 100% graduation rate. In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT name
FROM schools
JOIN graduation_rates ON schools.id = graduation_rates.school_id
WHERE graduated = 100;

--7 DESE is preparing a report on schools in the city of Cambridge. In 7.sql, write a SQL query to find the names of schools (public or charter!) in the Cambridge school district.
SELECT schools.name
FROM schools
JOIN districts ON schools.district_id = districts.id
WHERE districts.city = 'Cambridge';

--8 A parent wants to send their child to a district with many other students. In 8.sql, write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
SELECT d.name AS "Distrito Escolar", SUM(e.pupils) AS "Número de Alunos"
FROM districts AS d
JOIN expenditures AS e ON d.id = e.district_id
GROUP BY d.name;

--9 Another parent wants to send their child to a district with few other students. In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. Report only the name(s).
SELECT name
FROM districts
WHERE id = (
  SELECT district_id
  FROM expenditures
  ORDER BY pupils ASC
  LIMIT 1
);

--10 In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values. In 10.sql, write a SQL query to find the 10 public school districts with the highest per-pupil expenditures. Your query should return the names of the districts and the per-pupil expenditure for each.
SELECT d.name AS "District Name", AVG(e.per_pupil_expenditure) AS "Per-Pupil Expenditure"
FROM districts AS d
JOIN expenditures AS e ON d.id = e.district_id
WHERE d.type = 'Public School District'
GROUP BY d.name
ORDER BY "Per-Pupil Expenditure" DESC
LIMIT 10;

--11 Is there a relationship between school expenditures and graduation rates? In 11.sql, write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, sort by school name.
SELECT s.name AS "School Name", e.per_pupil_expenditure AS "Per-Pupil Expenditure", g.graduated AS "Graduation Rate"
FROM schools AS s
JOIN expenditures AS e ON s.district_id = e.district_id
JOIN graduation_rates AS g ON s.id = g.school_id
ORDER BY e.per_pupil_expenditure DESC, s.name ASC;

--12 A parent asks you for advice on finding the best public school districts in Massachusetts. In 12.sql, write a SQL query to find public school districts with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”. Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary. Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
SELECT d.name AS district_name, e.per_pupil_expenditure, s.exemplary
FROM districts AS d
JOIN staff_evaluations AS s ON d.id = s.district_id
JOIN expenditures AS e ON d.id = e.district_id
WHERE d.type = 'Public School District'
AND e.per_pupil_expenditure > (SELECT AVG(per_pupil_expenditure) FROM expenditures)
AND s.exemplary > (SELECT AVG(exemplary) FROM staff_evaluations)
ORDER BY s.exemplary DESC, e.per_pupil_expenditure DESC;

--13 In 13.sql, write a SQL query to answer a question you have about the data! The query should:
SELECT d.name AS "District Name", AVG(gr.dropped) AS "Average Dropout Rate"
FROM districts AS d
JOIN schools AS s ON d.id = s.district_id
JOIN graduation_rates AS gr ON s.id = gr.school_id
GROUP BY d.name
ORDER BY "Average Dropout Rate" DESC
LIMIT 10;
