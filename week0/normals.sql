-- NORMALS --
/*Notice that the earth is divided into a grid of coordinates—points that can identify most any location on earth. Each coordinate is a combination of latitude and longitude. And notice how each coordinate over an ocean has some normal ocean surface temperature associated with it!

In normals.db you’ll find a single table of coordinates, normals. In the normals table, you’ll find the following columns:

id, which uniquely identifies each row (coordinate) in the table
latitude, which is the degree of latitude (expressed in decimal format) for the coordinate
longitude, which is the degree of longitude (expressed in decimal format) for the coordinate
0m, which is the normal ocean surface temperature (i.e., the normal temperature at 0 meters of depth), in degrees Celsius, at the coordinate
5m, which is the normal ocean temperature at 5 meters of depth, in degrees Celsius, at the coordinate
10m, which is the normal ocean temperature at 10 meters of depth, in degrees Celsius, at the coordinate
And observations continue until 5500m, or 5500 meters of depth, for some coordinates! */

--In 1.sql, write a SQL query to find the normal ocean surface temperature in the Gulf of Maine, off the coast of Massachusetts. To find this temperature, look at the data associated with 42.5° of latitude and -69.5° of longitude.
SELECT 0m
FROM normals
WHERE latitude = 42.5
AND longitude = -69.5;

--In 2.sql, write a SQL query to find the normal temperature of the deepest sensor near the Gulf of Maine, at the same coordinate above.
SELECT 225m
FROM normals
WHERE latitude = 42.5
AND longitude = -69.5;

--In 3.sql, choose a location of your own and write a SQL query to find the normal temperature at 0 meters, 100 meters, and 200 meters. You might find Google Earth helpful if you’d like to find some coordinates to use!
SELECT 0m, 100m, 200m
FROM normals
WHERE latitude = 45.5
AND longitude = -122.5;

--In 4.sql, write a SQL query to find the lowest normal ocean surface temperature.
SELECT MIN(0m) AS LowestNormalOceanSurfaceTemperature
FROM normals;

--In 5.sql, write a SQL query to find the highest normal ocean surface temperature.
SELECT MAX(0m) AS HighestNormalOceanSurfaceTemperature
FROM normals;

/*In 6.sql, write a SQL query to return all normal ocean temperatures at 50m of depth, as well as their respective degrees of latitude and longitude, within the Arabian Sea. Include latitude, longitude, and temperature columns. For simplicity, assume the Arabian Sea is encased in the following four coordinates:
20° of latitude, 55° of longitude
20° of latitude, 75° of longitude
0° of latitude, 55° degrees of longitude
0° of latitude, 75° degrees of longitude*/
SELECT latitude, longitude, 50m
FROM normals
WHERE latitude BETWEEN 0 AND 20
AND longitude BETWEEN 55 AND 75;

-- In 7.sql, write a SQL query to find the average ocean surface temperature, rounded to two decimal places, along the equator. Call the resulting column “Average Equator Ocean Surface Temperature”.
SELECT AVG(0m) AS AverageEquatorOceanSurfaceTemperature
FROM normals
WHERE latitude BETWEEN -0.5 AND 0.5;

--In 8.sql, write a SQL query to find the 10 locations with the lowest normal ocean surface temperature, sorted coldest to warmest. If two locations have the same normal ocean surface temperature, sort by latitude, smallest to largest. Include latitude, longitude, and surface temperature columns.
SELECT latitude, longitude, 0m
FROM normals
ORDER BY 0m ASC
LIMIT 10;

--In 9.sql, write a SQL query to find the 10 locations with the highest normal ocean surface temperature, sorted warmest to coldest. If two locations have the same normal ocean surface temperature, sort by latitude, smallest to largest. Include latitude, longitude, and surface temperature columns.
SELECT latitude, longitude, 0m
FROM normals
ORDER BY 0m DESC
LIMIT 10;

--There are 180 whole degrees of latitude. In 10.sql, write a SQL query to determine how many points of latitude we have at least one data point for. (Why might we not have data points for all latitudes?)
SELECT COUNT(DISTINCT latitude) AS NumLatitudes
FROM normals;

