-- World Life Expectancy 2007-2022 Exploratory Data Analysis
SELECT * 
FROM world_life_expectancy
;


-- identifying highest and lowest increase in life expectancy over 15 years
SELECT Country, 
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) 
    AS Life_Increase_15_Years 
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;

-- finding the average life expectancy for each year across all countries
SELECT Year, ROUND(AVG(`Life expectancy`), 2) AS Year_Avg_Life_Exp
FROM world_life_expectancy
WHERE `Life expectancy`<> 0
GROUP BY Year
ORDER BY Year
;


-- Life Expectancy & GDP
-- comparing the averages of life expectancy GDP per country
SELECT Country, 
ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;


-- grouping countries into high or low GDP, then taking an average of the life 
-- expectancy of those groups for comparison
SELECT 
    SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
    AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) 
        AS High_GDP_Life_Exp,  
    SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
    AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) 
        AS Low_GDP_Life_Exp
FROM world_life_expectancy
;

-- Life Expectancy & Status
-- finding & comparing the avg life expectancy for developed vs. developing
-- countries
-- NOTE: the low count of developed countries could be throwing off the averages
SELECT Status, 
    COUNT(DISTINCT Country), 
    ROUND(AVG(`Life Expectancy`),1) AS Avg_Life_Exp
FROM world_life_expectancy
GROUP BY Status
;


-- Life Expectancy & BMI
-- comparing avg life expectancy to avg BMI for each country
SELECT Country, 
    ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
    ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;


-- Life Expectancy & Adult Mortality
-- using a rolling total to show the change in adult mortalty over 15 years
-- for Developing countries
SELECT Country, 
    Year,
    `Life expectancy`,
    `Adult Mortality`,
    SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) 
        AS Adult_Rolling_Total 
FROM world_life_expectancy
WHERE Status = 'Developing'
;

-- for Developed countries
SELECT Country, 
    Year,
    `Life expectancy`,
    `Adult Mortality`,
    SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) 
        AS Adult_Rolling_Total 
FROM world_life_expectancy
WHERE Status = 'Developed'
;


-- Life Expectancy & Infant Deaths
-- using a rolling total to show the change in infant deaths over 15 years
-- for Developing countries
SELECT Country, 
    Year,
    `Life expectancy`,
    `infant deaths`,
    SUM(`infant deaths`) OVER(PARTITION BY Country ORDER BY Year) 
        AS Infant_Rolling_Total 
FROM world_life_expectancy
WHERE Status = 'Developing'
;

-- for Developed countries
SELECT Country, 
    Year,
    `Life expectancy`,
    `infant deaths`,
    SUM(`infant deaths`) OVER(PARTITION BY Country ORDER BY Year) 
        AS Infant_Rolling_Total 
FROM world_life_expectancy
WHERE Status = 'Developed'
;


