/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - Analyze trends in sales, customer activity, and quantity over time.
    - Track yearly, monthly, and combined year-month performance to detect growth or decline patterns.
===============================================================================
*/


/*
===============================================================================
1. Yearly sales trends
===============================================================================
*/
SELECT 
    YEAR(order_date) AS year_sales, 
    SUM(sales_amount) AS total_sales, 
    COUNT(DISTINCT customer_key) AS total_customers, 
    SUM(quantity) AS total_quantity 
FROM gold.fact_sales 
WHERE order_date IS NOT NULL 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date);




/*
===============================================================================
2. Monthly sales trends (across all years)
===============================================================================
*/
SELECT 
    MONTH(order_date) AS month_sales, 
    SUM(sales_amount) AS total_sales, 
    COUNT(DISTINCT customer_key) AS total_customers, 
    SUM(quantity) AS total_quantity 
FROM gold.fact_sales 
WHERE order_date IS NOT NULL 
GROUP BY MONTH(order_date) 
ORDER BY MONTH(order_date);




/*
===============================================================================
3. Year-Month combined sales trends
===============================================================================
*/
SELECT 
    YEAR(order_date) AS year_sales, 
    MONTH(order_date) AS month_sales, 
    SUM(sales_amount) AS total_sales, 
    COUNT(DISTINCT customer_key) AS total_customers, 
    SUM(quantity) AS total_quantity 
FROM gold.fact_sales 
WHERE order_date IS NOT NULL 
GROUP BY YEAR(order_date), MONTH(order_date) 
ORDER BY YEAR(order_date), MONTH(order_date);
