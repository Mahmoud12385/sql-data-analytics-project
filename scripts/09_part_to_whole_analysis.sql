/*
===============================================================================
Category & Gender Contribution Analysis
===============================================================================
Purpose:
    - Identify which product categories, subcategories, and customer genders 
      contribute the most to total sales and quantity.
    - Understand the importance of each category/gender to overall performance.
===============================================================================
*/


/*
===============================================================================
1. Contribution of categories and subcategories to total sales and quantity
===============================================================================
*/
WITH category_sales AS (
    SELECT  
        dp.category, 
        dp.subcategory, 
        SUM(fs.sales_amount) AS total_sales, 
        SUM(fs.quantity) AS total_quantity
    FROM gold.dim_products dp
    INNER JOIN gold.fact_sales fs 
        ON fs.product_key = dp.product_key
    GROUP BY dp.category, dp.subcategory
)
SELECT  
    category,
    subcategory,
    total_sales,
    total_quantity,
    ROUND(CAST(total_sales AS FLOAT) / SUM(total_sales) OVER() * 100, 2) AS contribution_of_sales_to_total,
    ROUND(CAST(total_quantity AS FLOAT) / SUM(total_quantity) OVER() * 100, 2) AS contribution_of_quantity_to_total
FROM category_sales
ORDER BY contribution_of_sales_to_total DESC;




/*
===============================================================================
2. Contribution of customer genders to total sales
===============================================================================
*/
WITH gender_sales AS (
    SELECT  
        dp.gender, 
        SUM(fs.sales_amount) AS total_sales
    FROM gold.dim_customers dp
    INNER JOIN gold.fact_sales fs 
        ON fs.customer_key = dp.customer_key
    GROUP BY dp.gender
)
SELECT  
    gender,
    total_sales,
    ROUND(CAST(total_sales AS FLOAT) / SUM(total_sales) OVER() * 100, 2) AS contribution_to_total
FROM gender_sales
ORDER BY contribution_to_total DESC;
