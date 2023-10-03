-- CYBERCHASE --
/* In a database called cyberchase.db, using a table called episodes, chase answers to PBS’s questions about Cyberchase’s episodes thus far.
Each database has some “schema”—the tables and columns into which the data is organized. In cyberchase.db you’ll find a single table, episodes. In the episodes table, you’ll find the following columns:
id, which uniquely identifies each row (episode) in the table
season, which is the season number in which the episode aired
episode_in_season, which is the episode’s number within its given season
title, which is the episode’s title
topic, which identifies the ideas the episode aimed to teach
air_date, which is the date (expressed as YYYY-MM-DD) on which the episode “aired” (i.e., was published)
production_code, which is the unique ID used by PBS to refer to each episode internally */

-- In 1.sql, write a SQL query to list the titles of all episodes in Cyberchase’s original season, Season 1. --
select title from episodes where season = 1;

--In 2.sql, list the season number of, and title of, the first episode of every season.
select title, season from episodes where episode_in_season = 1;

--In 3.sql, find the production code for the episode “Hackerized!”.
SELECT production_code
FROM episodes
WHERE title = 'Hackerized!';

--In 4.sql, write a query to find the titles of episodes that do not yet have a listed topic.
SELECT title
FROM episodes
WHERE topic IS NULL;

--In 5.sql, find the title of the holiday episode that aired on December 31st, 2004.
SELECT title
FROM episodes
WHERE air_date = '2004-12-31';

--In 6.sql, list the titles of episodes from season 6 (2008) that were released early, in 2007.
SELECT title
FROM episodes
WHERE season = 6 AND air_date >= '2007-01-01' AND air_date <= '2007-12-31';

--In 7.sql, write a SQL query to list the titles and topics of all episodes teaching fractions.
SELECT title, topic
FROM episodes
WHERE topic LIKE '%fractions%';

--In 8.sql, write a query that counts the number of episodes released in the last 5 years, from 2018 to 2023, inclusive.
SELECT COUNT(*)
FROM episodes
WHERE strftime('%Y', air_date) BETWEEN '2018' AND '2023';

--In 9.sql, write a query that counts the number of episodes released in Cyberchase’s first 5 years, from 2002 to 2007, inclusive.
SELECT COUNT(*)
FROM episodes
WHERE air_date BETWEEN '2002-01-01' and '2007-12-31';

--In 10.sql, write a SQL query to list the ids, titles, and production codes of all episodes. Order the results by production code, from earliest to latest.
SELECT id, title, production_code
FROM episodes
ORDER BY production_code;

--In 11.sql, list the titles of episodes from season 5, in reverse alphabetical order.
SELECT title
FROM episodes
WHERE season = 5
ORDER BY title DESC;

--In 12.sql, count the number of unique episode titles.
SELECT COUNT(DISTINCT title)
FROM episodes;

--In 13.sql, write a SQL query to explore a question of your choice. This query should:
SELECT title
FROM episodes
WHERE season = 3 OR (season = 4 AND topic LIKE '%math%');



