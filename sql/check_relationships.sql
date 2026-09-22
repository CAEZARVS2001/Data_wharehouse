-- Confirm that each customer has only one order (1:1) customer_id with order_id, it must return 0 rows
SELECT 
    customer_id, 
    COUNT(*)
FROM analytics.stg_orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Confirm that each order has multiple payment methods (1:N) 
SELECT
    order_id,
    COUNT(*) AS payment_count
FROM analytics.stg_order_payments
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY payment_count DESC
LIMIT 10;

-- Confirm that each order has multiple reviews (1:N)
SELECT 
    order_id, 
    COUNT(*) as review_count
FROM analytics.stg_order_reviews
GROUP BY order_id
HAVING count(*) > 1
ORDER BY review_count DESC
LIMIT 10;

-- Confirm that each order can have multiple items (1:N)
SELECT 
    order_id, 
    COUNT(*) as item_count
FROM analytics.stg_order_items
GROUP BY order_id
ORDER BY item_count DESC
LIMIT 10;

-- Confirm that multiple sellers sold many products (M:N)
SELECT 
    product_id, 
    COUNT(DISTINCT seller_id) AS seller_count
FROM analytics.stg_order_items
GROUP BY product_id
HAVING COUNT(DISTINCT seller_id) > 1
ORDER BY seller_count DESC
LIMIT 10;

-- Confirm that for each product category, only exists one english translation  (1:1)
SELECT 
    product_category_name, 
    COUNT(DISTINCT product_category_name_english)
FROM analytics.stg_product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(DISTINCT product_category_name_english) > 1;

SELECT 
    product_category_name_english, 
    COUNT(DISTINCT product_category_name) as pt_variants
FROM analytics.stg_product_category_name_translation
GROUP BY product_category_name_english
HAVING COUNT(DISTINCT product_category_name) > 1;

-- Confirm that for each customer, only has many zip codes (N:1)
SELECT 
    customer_id, 
    COUNT(DISTINCT customer_zip_code_prefix)
FROM analytics.stg_customers
GROUP BY customer_id
HAVING COUNT(DISTINCT customer_zip_code_prefix) > 1;

-- Confirm that for each seller, only has many zip codes (N:1)
SELECT 
    seller_id, 
    COUNT(DISTINCT seller_zip_code_prefix)
FROM analytics.stg_sellers
GROUP BY seller_id
HAVING COUNT(DISTINCT seller_zip_code_prefix) > 1;