/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time
SELECT
*,
SUM(total_sales) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) accumlate_total_sales
FROM(
SELECT
DATETRUNC(MONTH,order_date)order_date,
SUM(sales_amount)total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
)t


SELECT
*,
AVG(total_sales) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) accumlate_avg_sales_by_year,

SUM(total_sales) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) accumlate_total_sales_by_year
FROM(
SELECT
DATETRUNC(MONTH,order_date)order_date,
SUM(sales_amount)total_sales,
AVG(sales_amount) avg_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
)t
