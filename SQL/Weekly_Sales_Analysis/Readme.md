# Data Mart Analysis

## Introduction
This project involves analyzing the sales performance and the impact of a major operational change at Data Mart, which introduced sustainable packaging in June 2020. The analysis is based on the `weekly_sales` dataset, with additional transformations and exploratory insights.

---

## Schema
The analysis uses the following schema:

| **Column Name**  | **Data Type**   | **Description**                          |
|-------------------|-----------------|------------------------------------------|
| `week_date`       | `date`          | Date representing the start of the week. |
| `region`          | `varchar(20)`   | Geographic region of sales.              |
| `platform`        | `varchar(20)`   | Sales platform (e.g., Retail, Shopify).  |
| `segment`         | `varchar(10)`   | Customer segmentation.                   |
| `customer`        | `varchar(20)`   | Customer identifier.                     |
| `transactions`    | `int`           | Number of transactions in the week.      |
| `sales`           | `int`           | Total sales amount for the week.         |

---

## Case Study Objectives
The project is divided into two parts:
1. **Data Cleansing**: Transform the raw `weekly_sales` table into a new table, `clean_weekly_sales`, with enriched data.
2. **Data Exploration**: Answer key business questions to gain insights into sales performance.

---

## Part A: Data Cleansing Steps
The `clean_weekly_sales` table includes the following transformations:
1. **`week_number`**: Added a column representing the week of the month.
2. **`month_number`**: Added a column for the calendar month.
3. **`calendar_year`**: Added a column with year values (2018, 2019, 2020).
4. **`age_band`**: Created a column using the following mappings from the `segment` column:
   - `1` → Young Adults
   - `2` → Middle Aged
   - `3, 4` → Retirees
5. **`demographic`**: Created a column using the following mappings:
   - `C` → Couples
   - `F` → Families
6. **`unknown` values**: Replaced `null` values in `segment`, `age_band`, and `demographic` with "unknown."
7. **`avg_transaction`**: Added a column for sales divided by transactions, rounded to 2 decimal places.

---

## Part B: Data Exploration
Key business questions addressed:
1. **Missing Weeks**: Identify week numbers that are not present in the dataset.
2. **Yearly Transactions**: Calculate the total number of transactions for each year.
3. **Regional Sales by Month**: Calculate the total sales for each region and month.
4. **Transactions by Platform**: Count the number of transactions for each platform.
5. **Retail vs. Shopify Sales**: Determine the percentage of sales for each platform by month.
6. **Demographic Sales Share**: Calculate the percentage contribution of each demographic to yearly sales.
7. **Top Contributors to Retail Sales**: Identify the age band and demographic contributing the most to Retail sales.

---

## SQL Queries
### 1. Data Cleansing

This script creates the `clean_weekly_sales` table with all required transformations.

### 2. Data Exploration

This script contains SQL queries to answer the business questions outlined in Part B.

---

## Setup and Usage
1. Clone this repository.
2. Load the `weekly_sales` table into your SQL environment.
3. Run the `clean_weekly_sales.sql` script to generate the `clean_weekly_sales` table.
4. Execute the `data_exploration.sql` script to generate insights and answer business questions.

---

## Insights
- The percentage of sales for Retail and Shopify varies by month, with distinct trends observed.
- Certain demographics and age bands dominate Retail sales.
- Missing weeks in the dataset indicate potential data gaps.


