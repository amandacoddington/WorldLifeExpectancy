-- World Health Expenditure Percentage Table Formatting
SELECT *
FROM healthexpenditure_raw;


-- removing table columns for years 1960-2006 & 2023 as those years are not in world_life_expectancy
ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD3;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD4;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD5;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD6;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD7;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD8;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD9;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD10;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD11;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD12;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD13;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD14;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD15;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD16;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD17;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD18;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD19;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD20;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD21;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD22;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD23;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD24;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD25;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD26;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD27;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD28;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD29;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD30;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD31;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD32;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD33;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD34;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD35;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD36;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD37;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD38;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD39;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD40;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD41;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD42;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD43;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD44;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD45;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD46;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD47;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD48;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD49;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD50;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD51;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD68;

ALTER TABLE healthexpenditure_raw
DROP COLUMN FIELD69;

SELECT *
FROM healthexpenditure_raw
;


-- removing "World Development Indicators" column as it is not needed
ALTER TABLE healthexpenditure_raw
DROP COLUMN `World Development Indicators`;


-- removing first row as it is empty
DELETE FROM healthexpenditure_raw
WHERE `Data Source` = 'Last Updated Date';


-- renaming columns
ALTER TABLE healthexpenditure_raw
RENAME COLUMN `Data Source` to Country;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD52 to `2007`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD53 to `2008`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD54 to `2009`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD55 to `2010`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD56 to `2011`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD57 to `2012`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD58 to `2013`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD59 to `2014`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD60 to `2015`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD61 to `2016`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD62 to `2017`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD63 to `2018`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD64 to `2019`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD65 to `2020`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD66 to `2021`;

ALTER TABLE healthexpenditure_raw
RENAME COLUMN FIELD67 to `2022`;

SELECT *
FROM healthexpenditure_raw
;


-- removing row 1 as it is not needed anymore after changing the headers
DELETE FROM healthexpenditure_raw
WHERE Country = 'Country Name';


-- changing wide format to long format
SELECT Country,
	2007 as Year,
    `2007` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2008 as Year,
    `2008` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2009 as Year,
    `2009` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2010 as Year,
    `2010` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2011 as Year,
    `2011` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2012 as Year,
    `2012` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2013 as Year,
    `2013` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2014 as Year,
    `2014` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2015 as Year,
    `2015` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2016 as Year,
    `2016` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2017 as Year,
    `2017` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2018 as Year,
    `2018` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2019 as Year,
    `2019` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2020 as Year,
    `2020` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2021 as Year,
    `2021` as HealthExpenditure
FROM healthexpenditure_raw
UNION ALL
SELECT Country,
	2022 as Year,
    `2022` as HealthExpenditure
FROM healthexpenditure_raw
ORDER BY Country, Year
;