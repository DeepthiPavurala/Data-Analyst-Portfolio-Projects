CREATE TABLE clean_weekly_sales AS
SELECT
  week_date,
  week(week_date) AS week_number,
  month(week_date) AS month_number,
  year(week_date) AS calendar_year,
  region,
  platform,
  CASE
    WHEN segment = 'null' THEN 'Unknown'
    ELSE segment
    END AS segment,
  CASE
    WHEN right(segment, 1) = '1' THEN 'Young Adults'
    WHEN right(segment, 1) = '2' THEN 'Middle Aged'
    WHEN right(segment, 1) IN ('3', '4') THEN 'Retirees'
    ELSE 'Unknown'
    END AS age_band,
  CASE
    WHEN left(segment, 1) = 'C' THEN 'Couples'
    WHEN left(segment, 1) = 'F' THEN 'Families'
    ELSE 'Unknown'
    END AS demographic,
  customer_type,
  transactions,
  sales,
  ROUND(
      sales / transactions,
      2
   ) AS avg_transaction
FROM weekly_sales;

## Data Exploration

## 1.Which week numbers are missing from the dataset?

with recursive all_week_numbers as(
select 1 as n
union all
select n+1 from all_week_numbers where n<53)
select n as week_number from all_week_numbers
where n not in (select distinct week_number from clean_weekly_sales);

## 2.How many transactions were there for each year in the dataset?
select  calendar_year, count(transactions) as "Number of transactions" from clean_weekly_sales group by calendar_year;

## 3.What is the total transactions for each calendar year in the dataset?
select  calendar_year, sum(transactions) 'Total Transactions' from clean_weekly_sales group by calendar_year;

## 4.What are the total sales for each region for each month?
select region, month_number as month, sum(sales) 'Total sales' from clean_weekly_sales group by month_number, region order by month_number, region;

## 5.What is the total count of transactions for each platform?
select  platform, count(transactions) as "Number of transactions" from clean_weekly_sales group by platform;

## 6.What is the percentage of sales for Retail vs Shopify for each month?
with percentage_sales as(
select 
month_number , calendar_year,platform,
sum(sales)*100/sum(sum(sales)) over (partition by calendar_year, month_number)  sales_percentage
from clean_weekly_sales group by month_number, calendar_year, platform)
select month_number, calendar_year,
max(case when platform = 'Retail' then sales_percentage end) as 'retail_percentage',
max(case when platform = 'Shopify' then sales_percentage end) as 'shopify_percentage' 
from percentage_sales
group by month_number, calendar_year
order by month_number, calendar_year;

## 7.What is the percentage of sales by demographic for each year in the dataset?
select calendar_year, demographic,
sum(sales)*100/sum(sum(sales)) over(partition by demographic) as percentage
from clean_weekly_sales
group by calendar_year, demographic
order by calendar_year, demographic;

## 8.Which age_band and demographic values contribute the most to Retail sales?

select age_band, demographic, sum(Sales) as total_sales
from clean_weekly_sales where platform = 'Retail'
group by age_band, demographic 
order by total_sales desc limit 1;





