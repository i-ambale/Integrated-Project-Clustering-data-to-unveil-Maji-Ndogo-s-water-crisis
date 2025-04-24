SELECT REPLACE(employee_name, ' ', '.') FROM employee; -- Replace the space with a full stop
SELECT LOWER(REPLACE(employee_name, ' ', '.')) FROM employee; -- Make it all lower case
SELECT CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov') AS new_email FROM employee; -- add it all together
UPDATE employee SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov'); -- Update all employees emails
SELECT email FROM employee; -- Check to confirm if it worked
SELECT LENGTH(phone_number) FROM employee; -- Length should be 12
SELECT LENGTH(TRIM(phone_number)) AS 'new_phone_number' FROM employee;
UPDATE employee SET phone_number = TRIM(phone_number); -- Update phone numbers
SELECT LENGTH(phone_number) FROM employee; -- Check if it worked

SELECT * FROM employee; 

SELECT DISTINCT town_name, 
  COUNT(employee_name) OVER (PARTITION BY town_name) AS employees_per_town
FROM employee
ORDER BY employees_per_town ASC;

SELECT * FROM visits -- Check the table to see the variables

SELECT DISTINCT assigned_employee_id, COUNT(visit_count) OVER (PARTITION BY assigned_employee_id) AS 'records_per_employee' FROM visits;

SELECT DISTINCT assigned_employee_id,
    COUNT(visit_count) OVER (PARTITION BY assigned_employee_id) AS 'records_per_employee' 
FROM visits
ORDER BY records_per_employee DESC
LIMIT 3;

SELECT * FROM employee; -- Check the table to see the variables

SELECT employee_name,
    email,
    phone_number
FROM employee
WHERE assigned_employee_id IN (1, 30, 34);

SELECT * FROM location; -- Check the table to see the variables

SELECT town_name, COUNT(location_id) AS 'records_per_town' FROM location GROUP BY town_name ORDER BY records_per_town DESC;

SELECT province_name, COUNT(location_id) AS 'records_per_province' FROM location GROUP BY province_name ORDER BY records_per_province DESC;

SELECT province_name, town_name, COUNT(location_id) AS 'records_per_town'
FROM location
GROUP BY province_name, town_name
ORDER BY province_name, records_per_town DESC;

SELECT location_type, COUNT(location_id) AS 'records_per_location' FROM location GROUP BY location_type ORDER BY records_per_location;

SELECT 23740 / (15910+23740) * 100;

SELECT * FROM water_source;

-- Number of people served
SELECT SUM(number_of_people_served) AS 'total_number_of_people' FROM water_source;

SELECT type_of_water_source, COUNT(type_of_water_source) AS 'total_number'
FROM water_source 
WHERE type_of_water_source IN ('well', 'tap_in_home', 'tap_in_home_broken', 'river')
GROUP BY type_of_water_source
ORDER BY total_number;

-- Average number of people served per water source
SELECT type_of_water_source, ROUND(AVG(number_of_people_served), 0) AS 'AVG_number_of_people_served'
FROM water_source
GROUP BY type_of_water_source
ORDER BY AVG_number_of_people_served;

-- Total people served per water source
SELECT type_of_water_source, SUM(number_of_people_served) AS 'total_people_served'
FROM water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;

-- Percentage of people served per water source
SELECT type_of_water_source,
  SUM(number_of_people_served) / -- divide by...
   (SELECT SUM(number_of_people_served) FROM water_source) -- total number of people served
    * 100 AS 'percentage_of_people_served'
FROM water_source
GROUP BY type_of_water_source
ORDER BY percentage_of_people_served DESC;

-- Percentage of people served per water source rounded off to zero decimal points
SELECT type_of_water_source,
  ROUND(SUM(number_of_people_served) / -- divide by...
   (SELECT SUM(number_of_people_served) FROM water_source) -- total number of people served
    * 100, 0) AS 'percentage_of_people_served'
FROM water_source
GROUP BY type_of_water_source
ORDER BY percentage_of_people_served DESC;

-- Ranking water source type according to number of people served
SELECT type_of_water_source, 
    SUM(number_of_people_served) AS 'total_people_served',
    RANK() OVER (ORDER BY SUM(number_of_people_served) DESC) AS 'rank_by_people_served'
FROM water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;

-- Ranking water source according to number of people served
SELECT source_id,
  type_of_water_source,
  number_of_people_served,
  RANK() OVER (ORDER BY number_of_people_served DESC) AS 'rank_per_source'
FROM water_source
ORDER BY number_of_people_served DESC;

-- Ranking taps and wells according to number of people served
SELECT source_id,
  type_of_water_source,
  number_of_people_served,
  RANK() OVER (ORDER BY number_of_people_served DESC) AS 'rank_per_source'
FROM water_source
WHERE type_of_water_source LIKE '%tap%' OR type_of_water_source = 'well'
ORDER BY number_of_people_served DESC;

-- Ranking water source according to number of people served using DENSE_RANK() 
SELECT source_id,
  type_of_water_source,
  number_of_people_served,
  DENSE_RANK() OVER (ORDER BY number_of_people_served DESC) AS 'dense_rank_per_source'
FROM water_source
ORDER BY number_of_people_served DESC;

-- Ranking taps and wells according to number of people served using DENSE_RANK()
SELECT source_id,
  type_of_water_source,
  number_of_people_served,
  DENSE_RANK() OVER (ORDER BY number_of_people_served DESC) AS 'rank_per_source'
FROM water_source
WHERE type_of_water_source LIKE '%tap%' OR type_of_water_source = 'well'
ORDER BY number_of_people_served DESC;

-- Ranking water source according to number of people served using ROW_NUMBER()
SELECT source_id,
  type_of_water_source,
  number_of_people_served,
  ROW_NUMBER() OVER (ORDER BY number_of_people_served DESC) AS 'rank_per_source'
FROM water_source
ORDER BY number_of_people_served DESC;

-- Ranking taps and wells according to number of people served using ROW_NUMBER()
SELECT source_id,
  type_of_water_source,
  number_of_people_served,
  ROW_NUMBER() OVER (ORDER BY number_of_people_served DESC) AS 'rank_per_source'
FROM water_source
WHERE type_of_water_source LIKE '%tap%' OR type_of_water_source = 'well'
ORDER BY number_of_people_served DESC;

SELECT * FROM visits; -- visits table info

SELECT TIMEDIFF(MAX(time_of_record), MIN(time_of_record)) AS time_span FROM visits;

SELECT TIMESTAMPDIFF(HOUR, MIN(time_of_record), MAX(time_of_record)) AS time_span_seconds
FROM visits;

SELECT TIMESTAMPDIFF(DAY, MIN(time_of_record), MAX(time_of_record)) AS time_span_seconds
FROM visits;

SELECT TIMESTAMPDIFF(WEEK, MIN(time_of_record), MAX(time_of_record)) AS time_span_seconds
FROM visits;

SELECT TIMESTAMPDIFF(MONTH, MIN(time_of_record), MAX(time_of_record)) AS time_span_seconds
FROM visits;

SELECT TIMESTAMPDIFF(YEAR, MIN(time_of_record), MAX(time_of_record)) AS time_span_seconds
FROM visits;

SELECT 
    AVG(NULLIF(time_in_queue, 0)) AS avg_queue_time
FROM visits;

SELECT DATE(time_of_record) AS day, AVG(time_in_queue) AS avg_queue_time
FROM visits
GROUP BY DATE(time_of_record)
ORDER BY day;