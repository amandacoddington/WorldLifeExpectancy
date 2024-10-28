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


-- removing GDP column because information is incorrect
ALTER TABLE world_life_expectancy
DROP COLUMN GDP;


-- joining world_gdp table (this is correct GDP from the World Bank) 
SELECT wle.Country, wle.Year, Status, gdp.GDP, `Life Expectancy`
FROM world_life_expectancy AS wle 
JOIN world_gdp AS gdp
    ON wle.Country = gdp.Country
    AND wle.Year = gdp.Year
ORDER BY wle.Country, gdp.Year
;

-- standardizing Country names between world life expectancy & world gdp tables to ensure accurate join 
UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'United States of America', 'United States')
WHERE Country = 'United States of America'
;

-- checking work
SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'United Kingdom of Great Britain and Northern Ireland', 'United Kingdom')
WHERE Country = 'United Kingdom of Great Britain and Northern Ireland'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country,'Republic of Korea','Korea, Rep.')
WHERE Country = 'Republic of Korea'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Korea%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country,'Democratic People''s Republic of Korea','Korea, Dem. People''s Rep.')
WHERE Country = 'Democratic People''s Republic of Korea'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Korea%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Bahamas', 'Bahamas, The')
WHERE Country = 'Bahamas'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Bahamas%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Bolivia (Plurinational State of)', 'Bolivia')
WHERE Country = 'Bolivia (Plurinational State of)'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Bolivia%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Côte d''Ivoire', 'Cote d''Ivoire')
WHERE Country = 'Côte d''Ivoire'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Cote%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Congo', 'Congo, Rep.')
WHERE Country = 'Congo'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Congo%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Congo', 'Congo, Rep.')
WHERE Country = 'Congo'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Congo%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Democratic Republic of the Congo', 'Congo, Dem. Rep.')
WHERE Country = 'Democratic Republic of the Congo'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Cz%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Egypt', 'Egypt, Arab Rep.')
WHERE Country = 'Egypt'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Egypt%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Gambia', 'Gambia, The')
WHERE Country = 'Gambia'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Gambia%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Iran (Islamic Republic of)', 'Iran, Islamic Rep.')
WHERE Country = 'Iran (Islamic Republic of)'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Iran%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Kyrgyzstan', 'Kyrgyz Republic')
WHERE Country = 'Kyrgyzstan'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Kyrgyz%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Lao People''s Democratic Republic', 'Lao PDR')
WHERE Country = 'Lao People''s Democratic Republic'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Lao%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Micronesia (Federated States of)', 'Micronesia, Fed. Sts.')
WHERE Country = 'Micronesia (Federated States of)'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Micro%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Republic of Moldova', 'Moldova')
WHERE Country = 'Republic of Moldova'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Moldova%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Saint Lucia', 'St. Lucia')
WHERE Country = 'Saint Lucia'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Lucia%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Saint Vincent and the Grenadines', 'St. Vincent and the Grenadines')
WHERE Country = 'Saint Vincent and the Grenadines'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Vincent%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Slovakia', 'Slovak Republic')
WHERE Country = 'Slovakia'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Slov%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'The former Yugoslav republic of Macedonia', 'North Macedonia')
WHERE Country = 'The former Yugoslav republic of Macedonia'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Mace%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'United Republic of Tanzania', 'Tanzania')
WHERE Country = 'United Republic of Tanzania'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Tanz%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Venezuela (Bolivarian Republic of)', 'Venezuela, RB')
WHERE Country = 'Venezuela (Bolivarian Republic of)'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Venez%'
;


UPDATE world_life_expectancy
SET Country = REPLACE(Country, 'Yemen', 'Yemen, Rep.')
WHERE Country = 'Yemen'
;

SELECT *
FROM world_life_expectancy
WHERE Country LIKE '%Yem%'
;


-- joining world_gdp & population to world_life_expectancy
SELECT wle.Country, wle.Year, Status, gdp.GDP, p.Population,
    `Life Expectancy`, `Adult Mortality`, BMI, Measles, Polio, Diphtheria, `HIV/AIDS`
FROM world_life_expectancy AS wle 
JOIN world_gdp AS gdp
    ON wle.Country = gdp.Country
    AND wle.Year = gdp.Year
JOIN population AS p 
    ON wle.Country = p.Country
    AND wle.Year = p.Year
ORDER BY wle.Country, gdp.Year
;


SELECT *
FROM world_life_expectancy;

-- removing HIV/AIDs & Measles columns because information is incorrect
ALTER TABLE world_life_expectancy
DROP COLUMN `HIV/AIDS`;

ALTER TABLE world_life_expectancy
DROP COLUMN Measles;

-- removing the following columns as they will not be used in this project
ALTER TABLE world_life_expectancy
DROP COLUMN `thinness  1-19 years`;

ALTER TABLE world_life_expectancy
DROP COLUMN `thinness 5-9 years`;

ALTER TABLE world_life_expectancy
DROP COLUMN Schooling;

SELECT *
FROM world_life_expectancy;


-- standardizing column names
ALTER TABLE world_life_expectancy
RENAME COLUMN `Life expectancy` to LifeExpectancy;

ALTER TABLE world_life_expectancy
RENAME COLUMN `Adult Mortality` to AdultMortality;

ALTER TABLE world_life_expectancy
RENAME COLUMN `infant deaths` to InfantDeaths;

ALTER TABLE world_life_expectancy
RENAME COLUMN `percentage expenditure` to HealthExpenditure;

ALTER TABLE world_life_expectancy
RENAME COLUMN `under-five deaths` to UnderFiveDeaths;


-- dropping HealthExpenditure column because information is incorrect
ALTER TABLE world_life_expectancy
DROP COLUMN HealthExpenditure;

SELECT * FROM world_life_expectancy;


-- formatting values in diphtheria and polio columns to percentage values
SELECT Country,
    Year,
    ROUND(Diphtheria * 0.01, 2) AS Diphtheria,
    ROUND(Polio * 0.01, 2) AS Polio
FROM world_life_expectancy
;

--updating world_life_exptectany table
UPDATE world_life_expectancy
SET Diphtheria = ROUND(Diphtheria * 0.01, 2),
    Polio = ROUND(Polio * 0.01, 2)
WHERE Country <> ''
;

SELECT * FROM world_life_expectancy;


-- joining world_gdp, population, health expenditure, measles, and HIV tables to world_life_expectancy table
SELECT w.Country, 
    w.Year, 
    Status, 
    LifeExpectancy,
    p.Population, 
    g.GDP, 
    he.HealthExpenditure,
    AdultMortality,
    InfantDeaths,
    UnderFiveDeaths,
    BMI,
    m.Measles,
    Diphtheria,
    Polio,
    h.HIV
FROM world_life_expectancy AS w 
JOIN world_gdp AS g
    ON w.Country = g.Country
    AND w.Year = g.Year
JOIN population AS p 
    ON w.Country = p.Country
    AND w.Year = p.Year
JOIN measles AS m
    ON w.Country = m.Country
    AND w.Year = m.Year 
JOIN hiv AS h 
    ON w.Country = h.Country
    AND w.Year = h.Year
JOIN healthexpenditure AS he
    ON w.Country = he.Country
    AND w.Year = he.Year
ORDER BY w.Country, g.Year
;






