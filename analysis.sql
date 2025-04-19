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

##Attach Proper State names:
WITH state_fips AS (
 SELECT '01' AS fips, 'Alabama' AS state UNION ALL
 SELECT '02', 'Alaska' UNION ALL
 SELECT '04', 'Arizona' UNION ALL
 SELECT '05', 'Arkansas' UNION ALL
 SELECT '06', 'California' UNION ALL
 SELECT '08', 'Colorado' UNION ALL
 SELECT '09', 'Connecticut' UNION ALL
 SELECT '10', 'Delaware' UNION ALL
 SELECT '11', 'District of Columbia' UNION ALL
 SELECT '12', 'Florida' UNION ALL
 SELECT '13', 'Georgia' UNION ALL
 SELECT '15', 'Hawaii' UNION ALL
 SELECT '16', 'Idaho' UNION ALL
 SELECT '17', 'Illinois' UNION ALL
 SELECT '18', 'Indiana' UNION ALL
 SELECT '19', 'Iowa' UNION ALL
 SELECT '20', 'Kansas' UNION ALL
 SELECT '21', 'Kentucky' UNION ALL
 SELECT '22', 'Louisiana' UNION ALL
 SELECT '23', 'Maine' UNION ALL
 SELECT '24', 'Maryland' UNION ALL
 SELECT '25', 'Massachusetts' UNION ALL
 SELECT '26', 'Michigan' UNION ALL
 SELECT '27', 'Minnesota' UNION ALL
 SELECT '28', 'Mississippi' UNION ALL
 SELECT '29', 'Missouri' UNION ALL
 SELECT '30', 'Montana' UNION ALL
 SELECT '31', 'Nebraska' UNION ALL
 SELECT '32', 'Nevada' UNION ALL
 SELECT '33', 'New Hampshire' UNION ALL
 SELECT '34', 'New Jersey' UNION ALL
 SELECT '35', 'New Mexico' UNION ALL
 SELECT '36', 'New York' UNION ALL
 SELECT '37', 'North Carolina' UNION ALL
 SELECT '38', 'North Dakota' UNION ALL
 SELECT '39', 'Ohio' UNION ALL
 SELECT '40', 'Oklahoma' UNION ALL
 SELECT '41', 'Oregon' UNION ALL
 SELECT '42', 'Pennsylvania' UNION ALL
 SELECT '44', 'Rhode Island' UNION ALL
 SELECT '45', 'South Carolina' UNION ALL
 SELECT '46', 'South Dakota' UNION ALL
 SELECT '47', 'Tennessee' UNION ALL
 SELECT '48', 'Texas' UNION ALL
 SELECT '49', 'Utah' UNION ALL
 SELECT '50', 'Vermont' UNION ALL
 SELECT '51', 'Virginia' UNION ALL
 SELECT '53', 'Washington' UNION ALL
 SELECT '54', 'West Virginia' UNION ALL
 SELECT '55', 'Wisconsin' UNION ALL
 SELECT '56', 'Wyoming'
)


SELECT
 fips_lookup.state,
 acs.median_income,
 acs.poverty,
 acs.total_pop,
 ROUND(acs.poverty / acs.total_pop, 4) AS poverty_rate
FROM `bigquery-public-data.census_bureau_acs.state_2019_5yr` acs
JOIN (
 SELECT geo_id, RIGHT(geo_id, 2) AS fips
 FROM `bigquery-public-data.census_bureau_acs.state_2019_5yr`
) fips_map
ON acs.geo_id = fips_map.geo_id
JOIN state_fips fips_lookup
ON fips_map.fips = fips_lookup.fips
ORDER BY poverty_rate DESC;
Percent of Adults with a Bachelor’s Degree:
SELECT
 RIGHT(geo_id, 2) AS fips,
 bachelors_degree,
 pop_25_years_over,
 ROUND(bachelors_degree / pop_25_years_over, 4) AS pct_bachelors_degree
FROM
 `bigquery-public-data.census_bureau_acs.state_2019_5yr`


 ##UNEMPLOYMENT RATE BY STATE:
SELECT
 geo_id,
 unemployed_pop,
 pop_in_labor_force,
 ROUND(unemployed_pop / pop_in_labor_force, 4) AS unemployment_rate
FROM
 `bigquery-public-data.census_bureau_acs.state_2019_5yr`
ORDER BY unemployment_rate DESC;


##RENT BURDEN BY STATE:
SELECT
 geo_id,
 percent_income_spent_on_rent
FROM
 `bigquery-public-data.census_bureau_acs.state_2019_5yr`
ORDER BY percent_income_spent_on_rent DESC;


##Window Function & Rank:
"Give each state a rank based on their income, from highest to lowest — but still keep all the individual state rows."
WITH ranked_income AS (
 SELECT
   RIGHT(geo_id, 2) AS fips,
   median_income,
   RANK() OVER (ORDER BY median_income DESC) AS income_rank
 FROM `bigquery-public-data.census_bureau_acs.state_2019_5yr`
)


SELECT
 fips,
 median_income,
 income_rank
FROM ranked_income
ORDER BY income_rank;

##Case When to Categorize Poverty:
“If the poverty rate is higher than 20%, label it ‘High Poverty’. If it's 12–20%, call it 'Moderate'. Otherwise, it's 'Low Poverty'.”
SELECT
 geo_id,
 poverty,
 total_pop,
 ROUND(poverty / total_pop, 4) AS poverty_rate,
 CASE
   WHEN ROUND(poverty / total_pop, 4) >= 0.20 THEN 'High Poverty'
   WHEN ROUND(poverty / total_pop, 4) >= 0.12 THEN 'Moderate Poverty'
   ELSE 'Low Poverty'
 END AS poverty_category
FROM `bigquery-public-data.census_bureau_acs.state_2019_5yr`
ORDER BY poverty_rate DESC;
