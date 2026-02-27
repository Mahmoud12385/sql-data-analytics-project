
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category 
FROM gold.dim_products

SELECT DISTINCT 
    subcategory 
FROM gold.dim_products

SELECT DISTINCT 
    product_name 
FROM gold.dim_products


-- Retrieve a list of  product lines
SELECT DISTINCT 
    product_line
FROM gold.dim_products
