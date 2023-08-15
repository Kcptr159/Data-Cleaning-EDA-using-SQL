/*
-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Collecting our data -----------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- first off, before importing our data we should create a database to load our data into it
-- or just load our table into an existing database. 

CREATE DATABASE PROJECT;


-- We want to work on our databse.

USE PROJECT;


-- Create a table that will contain the csv file we want to import. 

CREATE TABLE calls (
	ID CHAR(50),
	cust_name CHAR (50),
	sentiment CHAR (20),
	csat_score INT,
	call_timestamp CHAR (10),
	reason CHAR (20),
	city CHAR (20),
	state CHAR (20),
	channel CHAR (20),
	response_time CHAR (20),
	call_duration_minutes INT,
	call_center CHAR (20)
);
*/

-- Here we used table data import wizard and loaded our data in. Let's check how it looks.

SELECT * FROM callCenter;


-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Cleaning our data -------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------


-- The call_timestamp is a string, so we need to convert it to a date.
SELECT * FROM callCenter;


UPDATE callCenter SET call_timestamp = cast(call_timestamp as date);

UPDATE callCenter SET csat_score = NULL WHERE csat_score = 0;


SELECT * FROM callCenter LIMIT 10;


-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Exploring our data ------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------


-- lets see the shape pf our data, i.e, the number of columns and rows

SELECT COUNT(*) AS rows_num FROM callCenter;
SELECT COUNT(*) AS cols_num FROM information_schema.columns WHERE table_name = 'calls' ;


-- Checking the distinct values of some columns:

SELECT DISTINCT sentiment FROM callCenter;
SELECT DISTINCT reason FROM callCenter;
SELECT DISTINCT channel FROM callCenter;
SELECT DISTINCT response_time FROM callCenter;
SELECT DISTINCT call_center FROM callCenter;


-- The count and precentage from total of each of the distinct values we got:

SELECT sentiment, count(*) , ROUND((COUNT(*) / (SELECT COUNT(*) FROM callCenter)) * 100, 1) AS pct
FROM callCenter GROUP BY sentiment ORDER BY pct DESC;

SELECT reason, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callCenter)) * 100, 1) AS pct
FROM callCenter GROUP BY 1 ORDER BY 3 DESC;

SELECT channel, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callCenter)) * 100, 1) AS pct
FROM callCenter GROUP BY 1 ORDER BY 3 DESC;

SELECT response_time, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callCenter)) * 100, 1) AS pct
FROM callCenter GROUP BY 1 ORDER BY 3 DESC;

SELECT call_center, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM callCenter)) * 100, 1) AS pct
FROM callCenter GROUP BY 1 ORDER BY 3 DESC;

SELECT state, COUNT(*) as counter FROM callCenter GROUP BY state order by counter desc;

SELECT DAYNAME(call_timestamp) as Day_of_call, COUNT(*) num_of_calls FROM callCenter GROUP BY 1 ORDER BY 2 DESC;


-- Aggregations :

SELECT MIN(csat_score) AS min_score, MAX(csat_score) AS max_score, ROUND(AVG(csat_score),1) AS avg_score
FROM calls WHERE csat_score != 0; 

SELECT MIN(call_timestamp) AS earliest_date, MAX(call_timestamp) AS most_recent FROM calls;

SELECT MIN(call_duration_minutes) AS min_call_duration, MAX(call_duration_minutes) AS max_call_duration, AVG(call_duration_minutes) AS avg_call_duration FROM calls;

SELECT call_center, response_time, COUNT(*) AS count
FROM calls GROUP BY 1,2 ORDER BY 1,3 DESC;

SELECT call_center, AVG(call_duration_minutes) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT channel, AVG(call_duration_minutes) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT state, COUNT(*) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT state, reason, COUNT(*) FROM calls GROUP BY 1,2 ORDER BY 1,2,3 DESC;

SELECT state, sentiment , COUNT(*) FROM calls GROUP BY 1,2 ORDER BY 1,3 DESC;

SELECT state, AVG(csat_score) as avg_csat_score FROM calls WHERE csat_score != 0 GROUP BY 1 ORDER BY 2 DESC;

SELECT sentiment, AVG(call_duration_minutes) FROM calls GROUP BY 1 ORDER BY 2 DESC;

-- more advanced queries.

ALTER TABLE callCenter
RENAME COLUMN "call duration minutes" TO call_duration_minutes;


SELECT call_timestamp, MAX(call duration minutes) OVER(PARTITION BY call_timestamp) AS max_call_duration 
FROM callCenter
GROUP BY call_timestamp 
ORDER BY max_call_duration DESC;

select * from callCenter









