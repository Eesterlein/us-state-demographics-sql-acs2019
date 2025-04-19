# us-state-demographics-sql-acs2019
A SQL-based analysis of U.S. state-level demographics using 2019 ACS data
# US State-Level Demographic Insights (ACS 2019 + SQL)

This project analyzes 2019 American Community Survey (ACS) data by state using SQL in Google BigQuery. Key metrics like poverty rate, median income, education levels, and rent burden are visualized using Looker Studio.

## 🔍 Analysis Highlights
- State-level metrics calculated using SQL:
  - Poverty rate
  - Median household income
  - Bachelor's degree attainment
  - Unemployment rate
  - Rent burden (% income spent on rent)
  - Gini Index (income inequality)
- States are ranked by income and categorized by poverty rate
- All visuals built using Looker Studio with geographic mapping and scorecards

## ⚙️ Skills Used
- Common Table Expressions (CTEs)
- SQL Joins
- Window Functions (`RANK()`)
- Aggregate Functions (`ROUND()`, `SUM()`)
- Conditional Logic (`CASE WHEN`)
- Data Transformation (using `LPAD`, `RIGHT`)
- BigQuery SQL
- Looker Studio Dashboards

## 🗺 Dashboard

[🌐 View the Live Looker Studio Dashboard »](https://lookerstudio.google.com/s/mNjbN_gsXoQ)

![Dashboard Preview](dashboard-preview.png)

## 📂 Files Included
- `state_demographics_analysis.sql` – Full SQL script with data transformations
- `dashboard.pdf` – Export of the Looker Studio dashboard
- `README.md` – Project description and analysis summary

## 📊 Data Source
[American Community Survey 2019 5-Year Estimates](https://www.census.gov/programs-surveys/acs)

---
