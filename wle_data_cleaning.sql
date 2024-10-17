-- World Life Expectancy 2007-2022 Data Cleaning
SELECT *
FROM world_life_expectancy;


-- identifying duplicates
SELECT Country,
    Year,
    CONCAT(Country, Year),
    COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country,
    Year,
    CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;


-- identifying the row_id of the duplicates
SELECT Row_ID,
    CONCAT(Country, Year),
    ROW_NUMBER() OVER(
        PARTITION BY CONCAT(Country, Year)
        ORDER BY CONCAT(Country, Year)
    ) AS Row_Num
FROM world_life_expectancy;


-- filtering the results of the above query for row numbers that are greater 
-- than 1 which gives the row_id for the duplicates
SELECT *
FROM (
        SELECT Row_ID,
            CONCAT(Country, Year),
            ROW_NUMBER() OVER(
                PARTITION BY CONCAT(Country, Year)
                ORDER BY CONCAT(Country, Year)
            ) AS Row_Num
        FROM world_life_expectancy
    ) AS Row_table
WHERE Row_Num > 1;


-- removing the duplicates
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
        SELECT Row_ID
        FROM (
                SELECT Row_ID,
                    CONCAT(Country, Year),
                    ROW_NUMBER() OVER(
                        PARTITION BY CONCAT(Country, Year)
                        ORDER BY CONCAT(Country, Year)
                    ) AS Row_Num
                FROM world_life_expectancy
            ) AS Row_table
        WHERE Row_Num > 1
    );


-- addressing missing data in Status column
-- identifying rows that are blank in the status column
SELECT *
FROM world_life_expectancy
WHERE Status = '';


-- checking to ensure each country has at least one status column to pull from 
-- & determining what values are used in the status column
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> '';


-- identifying countries that have 'developing' as their status
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';


-- updating the table & populating 'Developing' in blank rows under status for
-- countries that were identified in previous query 
-- by updating the table, joining the table to itself in the update statement
UPDATE world_life_expectancy t1
    JOIN world_life_expectancy t2 
    ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
    AND t2.Status <> ''
    AND t2.Status = 'Developing';


-- same process for the 'Developed' status countries
UPDATE world_life_expectancy t1
    JOIN world_life_expectancy t2 
    ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
    AND t2.Status <> ''
    AND t2.Status = 'Developed';


-- double checking work and checking for null values
SELECT *
FROM world_life_expectancy
WHERE Status IS NULL;
SELECT *
FROM world_life_expectancy
WHERE Status = '';


-- addressing missing data in Life Expectancy column
-- identifying blank rows
SELECT Country,
    Year,
    `Life expectancy`
FROM world_life_expectancy;


-- if a country's life expectancy is blank for a given year, will use the 
-- average of the previous year and next year's life expectancy to populate life 
-- expectancy for the blank year
SELECT t1.Country, t1.Year, t1.`Life expectancy`,
    t2.Country, t2.Year, t2.`Life expectancy`,
    t3.Country, t3.Year, t3.`Life expectancy`,
    ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1   
WHERE t1.`Life expectancy` = ''
;


-- updating the table to include the populated life expectancy 
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1 
JOIN world_life_expectancy t3 
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET  t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE  t1.`Life expectancy` = ''
;


-- double checking it populated the life expectancy correctly and ensuring there
-- is no more blanks
SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;

SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;