/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
       - total orders
       - total sales
       - total quantity purchased
       - total products
       - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value
        - average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================

/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
CREATE VIEW gold.report_customers AS
WITH base_query as(
SELECT 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
f.price,
c.customer_key ,
c.first_name + ' '+c.last_name AS customer_name,
DATEDIFF(YEAR,c.birth_date,GETDATE()) age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
) 
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
,customer_aggregations AS(
SELECT 
customer_key,
customer_name,
age,
SUM(sales_amount) total_sales,
COUNT(DISTINCT order_number) total_orders,
SUM(quantity) total_quantity,
COUNT( DISTINCT product_key) total_products,
MAX(order_date) last_order_date,
DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) life_span
FROM base_query
GROUP BY 
customer_key,
customer_name,
age
 )

SELECT 
customer_key,
customer_name,
age,
CASE 
	 WHEN age < 20 THEN 'Under 20'
	 WHEN age between 20 and 29 THEN '20-29'
	 WHEN age between 30 and 39 THEN '30-39'
	 WHEN age between 40 and 49 THEN '40-49'
	 ELSE '50 and above'
END AS age_group,
total_sales,
total_orders,
total_quantity,
total_products,
last_order_date,
DATEDIFF(MONTH,last_order_date,GETDATE()) recency,--months since last order
life_span,
-- Compuate average order value (AVO)
CASE WHEN total_orders = 0 THEN 0
     ELSE total_sales / total_orders
END avg_order_value,
-- Compuate average monthly spend
CASE WHEN life_span = 0 THEN total_sales
     ELSE total_sales / life_span 
END avg_monthly_spend,

CASE WHEN total_sales > 5000 AND life_span >=12 THEN 'VIP'
	 WHEN total_sales <= 5000 AND life_span >=12THEN 'Regular'
	 ELSE 'New'
END customer_segment
FROM customer_aggregations

