/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

-- Year-over-Year Analysis
WITH yearly_product_sales as (
SELECT 
YEAR(order_date) year_sales,
dp.product_name,
SUM(sales_amount) current_sales
FROM gold.fact_sales fs
JOIN gold.dim_products dp
ON fs.product_key = dp.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date) , dp.product_name
)

SELECT 
year_sales,
product_name,
current_sales,
AVG(current_sales) OVER(PARTITION BY product_name )avg_sales,
current_sales - AVG(current_sales) OVER(PARTITION BY product_name ) diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name ) > 0 THEN 'Above AVG'
     WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name ) < 0 THEN 'Below AVG'
        ELSE 'AVG' 
END avg_change,
LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year_sales) prv_year_sales,
current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year_sales) diff_prv,
CASE WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year_sales) > 0 THEN 'Increase'
     WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year_sales) < 0 THEN 'decrease'
        ELSE 'Same' 
END prv_year_change
FROM yearly_product_sales






