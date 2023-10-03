/* In players.db you’ll find a single table, players. In the players table, you’ll find the following columns:

id, which uniquely identifies each row (player) in the table
first_name, which is the first name of the player
last_name, which is the last name of the player
bats, which is the side (R for right or L for left) the player bats on
throws, which is the hand (R for right or L for left) the player throws with
weight, which is the player’s weight in pounds
height, which is the player’s height in inches
debut, which is the date (expressed as YYYY-MM-DD) the player began their career in the MLB
final_game, which is the date (expressed as YYYY-MM-DD) the player played their last game in the MLB
birth_year, which is the year the player was born
birth_month, which is the month (expressed as an integer) the player was born
birth_day, which is the day the player was born
birth_city, which is the city in which the player was born
birth_state, which is the state in which the player was born
birth_country, which is the country in which the player was born */

-- In 1.sql, write a SQL query to find the hometown (including city, state, and country) of Jackie Robinson.
SELECT birth_city, birth_state, birth_country
FROM players
WHERE first_name = 'Jackie' AND last_name = 'Robinson';

-- In 2.sql, write a SQL query to find the side (e.g., right or left) Babe Ruth hit.
SELECT bats
FROM players
WHERE first_name = 'Babe' AND last_name = 'Ruth';

-- In 3.sql, write a SQL query to find the ids of rows for which a value in the column debut is missing.
SELECT id
FROM players
WHERE debut IS NULL;

-- In 4.sql, write a SQL query to find the first and last names of players who were not born in the United States. Sort the results alphabetically by first name, then by last name.
SELECT first_name, last_name
FROM players
WHERE birth_country IS NOT NULL AND birth_country <> 'United States'
ORDER BY last_name ASC, first_name ASC;

-- In 5.sql, write a SQL query to return the first and last names of all right-handed batters. Sort the results alphabetically by first name, then by last name.
SELECT first_name, last_name
FROM players
WHERE bats = 'R'
ORDER BY first_name ASC, last_name ASC;

-- In 6.sql, write a SQL query to return the first name, last name, and debut date of players born in Pittsburgh, Pennsylvania (PA). Sort the results first by debut date—from most recent to oldest—then alphabetically by first name, followed by last name.
SELECT first_name, last_name, debut
FROM players
WHERE birth_city = 'Pittsburgh' AND birth_state = 'PA'
ORDER BY debut DESC, first_name ASC, last_name ASC;

-- In 7.sql, write a SQL query to count the number of players who bat (or batted) right-handed and throw (or threw) left-handed, or vice versa.
SELECT COUNT(*)
FROM players
WHERE (bats = 'R' AND throws = 'L') OR (bats = 'L' AND throws = 'R');

-- In 8.sql, write a SQL query to find the average height and weight, rounded to two decimal places, of baseball players who debuted on or after January 1st, 2000. Return the columns with the name “Average Height” and “Average Weight”, respectively.
SELECT ROUND(AVG(height), 2) AS "Average Height", ROUND(AVG(weight), 2) AS "Average Weight"
FROM players
WHERE debut >= '2000-01-01';

-- In 9.sql, write a SQL query to find the players who played their final game in the MLB in 2022. Sort the results alphabetically by first name, then by last name.
SELECT first_name, last_name
FROM players
WHERE final_game >= '2022-01-01' AND final_game <= '2022-12-31'
ORDER BY first_name, last_name;

/*In 10.sql, write SQL query to answer a question of your choice. This query should:
Make use of AS to rename a column
Involve at least condition, using WHERE
Sort by at least one column using ORDER BY*/
SELECT first_name, last_name, bats AS "Batting Side"
FROM players
WHERE bats = 'L'
ORDER BY "Batting Side" DESC, first_name ASC, last_name ASC;
