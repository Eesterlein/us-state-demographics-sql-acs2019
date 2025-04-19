/*
This project uses the **American Community Survey (ACS)** data from the U.S. Census Bureau, accessed via the `bigquery-public-data.census_bureau_acs` dataset, to analyze trends on income, poverty, education, unemployment, inequality, and other quality of life metrics.
Skills used: Joins, CTE's, Case statments, Windows Functions, Aggregate Functions, Ordering and ranking, Data Formatting and Cleaning
*/

##Poverty Rate + Median Income by State:
SELECT
 geo_id,
 median_income,
 poverty,
 total_pop,
 ROUND(poverty / total_pop, 4) AS poverty_rate
FROM
 `bigquery-public-data.census_bureau_acs.state_2019_5yr`
ORDER BY poverty_rate DESC;
