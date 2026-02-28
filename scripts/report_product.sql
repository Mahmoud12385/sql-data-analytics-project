/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================

/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/

CREATE VIEW gold.report_products AS
WITH base_query as (
SELECT 
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost,
f.order_number,
f.order_date,
f.sales_amount,
f.quantity,
f.price,
f.customer_key 
FROM gold.dim_products p
LEFT JOIN gold.fact_sales f
ON p.product_key = f.product_key
WHERE order_date IS NOT NULL

)

/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
,product_aggregations AS(
SELECT 
product_key,
product_name,
category,
subcategory,
SUM(sales_amount) total_sales,
COUNT(DISTINCT order_number) total_orders,
SUM(quantity) total_quantity,
COUNT( DISTINCT product_key) total_products,
MAX(order_date) last_order_date,
DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) life_span,
COUNT(DISTINCT customer_key) total_customers
FROM base_query
GROUP BY 
product_key,
product_name,
category,
subcategory
)
/*---------------------------------------------------------------------------
  3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/
SELECT 
product_key,
product_name,
category,
subcategory,
total_sales,
total_orders,
total_quantity,
total_products,
last_order_date,
life_span,
total_customers,
DATEDIFF(MONTH,last_order_date,GETDATE())recency,--months since last order
CASE 
    WHEN total_sales > 50000 THEN 'High-Performance'
    WHEN total_sales >= 10000 THEN 'Mid-Range'
    ELSE 'Low-Performer'
END AS product_segment,
-- Compuate average order value (AOV)
CASE WHEN total_orders = 0 THEN 0
     ELSE total_sales / total_orders
END avg_order_value,
-- Compuate average monthly Revenue
CASE WHEN life_span = 0 THEN total_sales
     ELSE total_sales / life_span 
END avg_monthly_spend,
-- Average Order Revenue (AOR)
CASE WHEN total_orders = 0 THEN total_sales
     ELSE total_sales / total_orders 
END avg_order_revenue
FROM product_aggregations
-- only consider valid sales dates



-- Average Monthly Revenue
