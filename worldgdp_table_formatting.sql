-- World GDP Table Formatting
-- NOTE: Original world life exptectancy had incorrect GDP data
-- joining this table to world life expectancy table
SELECT *
FROM world_gdp
;

-- removing table columns for years 1960-2006 & 2023 as those years are not in original dataset
ALTER TABLE world_gdp
DROP COLUMN FIELD3;

ALTER TABLE world_gdp
DROP COLUMN FIELD4;

ALTER TABLE world_gdp
DROP COLUMN FIELD5;

ALTER TABLE world_gdp
DROP COLUMN FIELD6;

ALTER TABLE world_gdp
DROP COLUMN FIELD7;

ALTER TABLE world_gdp
DROP COLUMN FIELD8;

ALTER TABLE world_gdp
DROP COLUMN FIELD9;

ALTER TABLE world_gdp
DROP COLUMN FIELD10;

ALTER TABLE world_gdp
DROP COLUMN FIELD11;

ALTER TABLE world_gdp
DROP COLUMN FIELD12;

ALTER TABLE world_gdp
DROP COLUMN FIELD13;

ALTER TABLE world_gdp
DROP COLUMN FIELD14;

ALTER TABLE world_gdp
DROP COLUMN FIELD15;

ALTER TABLE world_gdp
DROP COLUMN FIELD16;

ALTER TABLE world_gdp
DROP COLUMN FIELD17;

ALTER TABLE world_gdp
DROP COLUMN FIELD18;

ALTER TABLE world_gdp
DROP COLUMN FIELD19;

ALTER TABLE world_gdp
DROP COLUMN FIELD20;

ALTER TABLE world_gdp
DROP COLUMN FIELD21;

ALTER TABLE world_gdp
DROP COLUMN FIELD22;

ALTER TABLE world_gdp
DROP COLUMN FIELD23;

ALTER TABLE world_gdp
DROP COLUMN FIELD24;

ALTER TABLE world_gdp
DROP COLUMN FIELD25;

ALTER TABLE world_gdp
DROP COLUMN FIELD26;

ALTER TABLE world_gdp
DROP COLUMN FIELD27;

ALTER TABLE world_gdp
DROP COLUMN FIELD28;

ALTER TABLE world_gdp
DROP COLUMN FIELD29;

ALTER TABLE world_gdp
DROP COLUMN FIELD30;

ALTER TABLE world_gdp
DROP COLUMN FIELD31;

ALTER TABLE world_gdp
DROP COLUMN FIELD32;

ALTER TABLE world_gdp
DROP COLUMN FIELD33;

ALTER TABLE world_gdp
DROP COLUMN FIELD34;

ALTER TABLE world_gdp
DROP COLUMN FIELD35;

ALTER TABLE world_gdp
DROP COLUMN FIELD36;

ALTER TABLE world_gdp
DROP COLUMN FIELD37;

ALTER TABLE world_gdp
DROP COLUMN FIELD38;

ALTER TABLE world_gdp
DROP COLUMN FIELD39;

ALTER TABLE world_gdp
DROP COLUMN FIELD40;

ALTER TABLE world_gdp
DROP COLUMN FIELD41;

ALTER TABLE world_gdp
DROP COLUMN FIELD42;

ALTER TABLE world_gdp
DROP COLUMN FIELD43;

ALTER TABLE world_gdp
DROP COLUMN FIELD44;

ALTER TABLE world_gdp
DROP COLUMN FIELD45;

ALTER TABLE world_gdp
DROP COLUMN FIELD46;

ALTER TABLE world_gdp
DROP COLUMN FIELD47;

ALTER TABLE world_gdp
DROP COLUMN FIELD48;

ALTER TABLE world_gdp
DROP COLUMN FIELD49;

ALTER TABLE world_gdp
DROP COLUMN FIELD50;

ALTER TABLE world_gdp
DROP COLUMN FIELD51;

ALTER TABLE world_gdp
DROP COLUMN FIELD68;

ALTER TABLE world_gdp
DROP COLUMN FIELD69;

SELECT *
FROM world_gdp
;

-- removing "World Development Indicators" column as it is not needed
ALTER TABLE world_gdp
DROP COLUMN `World Development Indicators`;


-- removing first row as it is empty
DELETE FROM world_gdp
WHERE `Data Source` = 'Last Updated Date';
 
-- renaming columns
ALTER TABLE world_gdp
RENAME COLUMN `Data Source` to Country;

ALTER TABLE world_gdp
RENAME COLUMN FIELD52 to `2007`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD53 to `2008`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD54 to `2009`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD55 to `2010`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD56 to `2011`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD57 to `2012`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD58 to `2013`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD59 to `2014`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD60 to `2015`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD61 to `2016`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD62 to `2017`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD63 to `2018`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD64 to `2019`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD65 to `2020`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD66 to `2021`;

ALTER TABLE world_gdp
RENAME COLUMN FIELD67 to `2022`;

SELECT *
FROM world_gdp
;


-- removing row 1 as it is not needed anymore after changing the headers
DELETE FROM world_gdp
WHERE Country = 'Country Name';


-- removing row labelled 'not classified' as it is empty
DELETE FROM world_gdp
WHERE Country = 'Not classified';


-- changing wide format to long format
SELECT Country,
	2007 as Year,
    `2007` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2008 as Year,
    `2008` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2009 as Year,
    `2009` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2010 as Year,
    `2010` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2011 as Year,
    `2011` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2012 as Year,
    `2012` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2013 as Year,
    `2013` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2014 as Year,
    `2014` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2015 as Year,
    `2015` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2016 as Year,
    `2016` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2017 as Year,
    `2017` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2018 as Year,
    `2018` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2019 as Year,
    `2019` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2020 as Year,
    `2020` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2021 as Year,
    `2021` as GDP
FROM world_gdp
UNION ALL
SELECT Country,
	2022 as Year,
    `2022` as GDP
FROM world_gdp
ORDER BY Country, Year
;
