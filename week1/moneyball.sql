/*
The year is 2001. You’ve been hired to help make the most of the Oakland Athletics baseball team’s dwindling player budget. Each year, teams like the “A’s” hire new baseball players. Unfortunately, you’re low on star players—and on funds. Though, with a bit of SQL and some luck, who says you can’t still create a team that defies expectations?
Given a database called moneyball.db—one that contains information on players, their performances, and their salaries—help the Oakland Athletics find the value in players others might miss.
*/

--1 You should start by getting a sense for how average player salaries have changed over time. In 1.sql, write a SQL query to find the average player salary by year.
SELECT year, ROUND(AVG(salary), 2) AS "average salary"
FROM salaries
GROUP BY year
ORDER BY year DESC;

--2 Your general manager (i.e., the person who makes decisions about player contracts) asks you whether the team should trade a current player for Cal Ripken Jr., a star player who’s likely nearing his retirement. In 2.sql, write a SQL query to find Cal Ripken Jr.’s salary history.
SELECT year, salary
FROM salaries
JOIN players ON salaries.player_id = players.id
WHERE first_name = "Cal" AND last_name = "Ripken" AND birth_year = 1960
ORDER BY year DESC;

--3 Your team is going to need a great home run hitter. Ken Griffey Jr., a long-time Silver Slugger and Gold Glove award winner, might be a good prospect. In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.
SELECT year, HR AS "home runs"
FROM performances
JOIN players ON performances.player_id = players.id
WHERE first_name = "Ken" AND last_name = "Griffey" AND birth_year = 1969
ORDER BY year DESC;

--4 You need to make a recommendation about which players the team should consider hiring. With the team’s dwindling budget, the general manager wants to know which players were paid the lowest salaries in 2001. In 4.sql, write a SQL query to find the 50 players paid the least in 2001.
SELECT first_name, last_name, salary
FROM salaries
JOIN players ON salaries.player_id = players.id
WHERE year = 2001
ORDER BY salary, first_name, last_name, players.id
LIMIT 50;

--5 It’s a bit of a slow day in the office. Though Satchel no longer plays, in 5.sql, write a SQL query to find all teams that Satchel Paige played for.
SELECT DISTINCT name
FROM teams
JOIN performances ON teams.id = performances.team_id
JOIN players ON performances.player_id = players.id
WHERE first_name = "Satchel" AND last_name = "Paige";

--6 Which teams might be the biggest competition for the A’s this year? In 6.sql, write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
SELECT teams.name, SUM(performances.H) AS "total hits"
FROM teams
JOIN performances ON teams.id = performances.team_id
WHERE performances.year = 2001
GROUP BY teams.id
ORDER BY "total hits" DESC
LIMIT 5;

--7 You need to make a recommendation about which player (or players) to avoid recruiting. In 7.sql, write a SQL query to find the name of the player who’s been paid the highest salary, of all time, in Major League Baseball.
SELECT first_name, last_name
FROM players
JOIN salaries ON players.id = salaries.player_id
WHERE salary = (SELECT MAX(salary) FROM salaries)

--8 How much would the A’s need to pay to get the best home run hitter this past season? In 8.sql, write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
SELECT s.salary
FROM salaries AS s
JOIN performances AS p ON s.player_id = p.player_id AND s.year = p.year
WHERE p.year = 2001
ORDER BY p.HR DESC
LIMIT 1;

--9 What salaries are other teams paying? In 9.sql, write a SQL query to find the 5 lowest paying teams (by average salary) in 2001.
SELECT teams.name, ROUND(AVG(salaries.salary), 2) AS "average salary"
FROM teams
JOIN salaries ON teams.id = salaries.team_id
WHERE salaries.year = 2001
GROUP BY teams.id
ORDER BY "average salary" ASC
LIMIT 5;

--10 The general manager has asked you for a report which details each player’s name, their salary for each year they’ve been playing, and their number of home runs for each year they’ve been playing. To be precise, the table should include:
SELECT players.first_name, players.last_name, salaries.year, salaries.salary, performances.HR
FROM players
JOIN salaries ON players.id = salaries.player_id
JOIN performances ON players.id = performances.player_id AND salaries.year = performances.year
ORDER BY players.id ASC, performances.year DESC, performances.HR DESC, salaries.salary DESC;

--11 You need a player that can get hits. Who might be the most underrated? In 11.sql, write a SQL query to find the 10 least expensive players per hit in 2001.
SELECT p.first_name, p.last_name, CAST(s.salary/(p2.H*1.0) AS INTEGER) AS "dollars per hit"
FROM players p
JOIN salaries s ON p.id = s.player_id
JOIN performances p2 ON p.id = p2.player_id
WHERE s.year = 2001 AND p2.year = 2001 AND p2.H > 0
ORDER BY "dollars per hit", p.first_name, p.last_name
LIMIT 10;

--12 Hits are great, but so are RBIs! In 12.sql, write a SQL query to find the players among the 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001.
SELECT players.first_name, players.last_name
FROM players
JOIN salaries ON players.id = salaries.player_id
JOIN performances ON players.id = performances.player_id AND salaries.year = performances.year
WHERE performances.year = 2001 AND performances.H > 0 AND salaries.salary / performances.H IN (
    SELECT ROUND(salaries.salary / performances.H, 2) AS "dollars per hit"
    FROM salaries
    JOIN performances ON salaries.player_id = performances.player_id AND salaries.year = performances.year
    WHERE performances.year = 2001 AND performances.H > 0
    ORDER BY "dollars per hit" ASC
    LIMIT 10
) AND salaries.salary / performances.RBI IN (
    SELECT ROUND(salaries.salary / performances.RBI, 2) AS "dollars per RBI"
    FROM salaries
    JOIN performances ON salaries.player_id = performances.player_id AND salaries.year = performances.year
    WHERE performances.year = 2001 AND performances.RBI > 0
    ORDER BY "dollars per RBI" ASC
    LIMIT 10
)
ORDER BY players.id ASC;