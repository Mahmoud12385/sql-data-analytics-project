/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - Identify top-performing entities such as customers, products, or orders.
    - Support decision-making by ranking based on sales metrics, quantity, or revenue.
    - Enable prioritization of high-value targets and trend analysis.
===============================================================================
*/



/*
===============================================================================
1. Top 10 customers by total sales amount
===============================================================================
*/
SELECT TOP 10
    c.customer_key,
    c.first_name + ' ' + c.last_name AS customer_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_sales DESC;




/*
===============================================================================
2. Top 10 products by total sales amount
===============================================================================
*/
SELECT TOP 10
    p.product_key,
    p.product_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_key, p.product_name
ORDER BY total_sales DESC;








/*
===============================================================================
3. Rank customers by quantity purchased
===============================================================================
*/
SELECT
    c.customer_key,
    c.first_name + ' ' + c.last_name AS customer_name,
    SUM(f.quantity) AS total_quantity,
    DENSE_RANK() OVER (ORDER BY SUM(f.quantity) DESC) AS quantity_rank
FROM gold.fact_sales f
JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name;




/*
===============================================================================
4. Monthly sales ranking per product
===============================================================================
*/
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    f.product_key,
    p.product_name,
    SUM(f.sales_amount) AS monthly_sales,
    ROW_NUMBER() OVER (
        PARTITION BY YEAR(order_date), MONTH(order_date)
        ORDER BY SUM(f.sales_amount) DESC
    ) AS monthly_sales_rank
FROM gold.fact_sales f
JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY YEAR(order_date), MONTH(order_date), f.product_key, p.product_name;




/*
===============================================================================
5. Top 10 customers by average order value
===============================================================================
*/
SELECT TOP 10
    c.customer_key,
    c.first_name + ' ' + c.last_name AS customer_name,
    AVG(f.sales_amount) AS avg_order_value
FROM gold.fact_sales f
JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY avg_order_value DESC;
