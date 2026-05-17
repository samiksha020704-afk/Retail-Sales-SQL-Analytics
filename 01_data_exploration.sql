SELECT * FROM olist_customers_dataset LIMIT 5;

SELECT * FROM olist_orders_dataset LIMIT 5;

SELECT * FROM olist_order_items_dataset LIMIT 5;

SELECT * FROM olist_order_payments_dataset LIMIT 5;

SELECT * FROM olist_products_dataset LIMIT 5;

SELECT 
COUNT(*) - COUNT(product_category_name) 
AS null_categories
FROM olist_products_dataset;

SELECT order_id,
       COUNT(*)
FROM olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT o.order_id,
       c.customer_city,
       c.customer_state
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
ON o.customer_id = c.customer_id
LIMIT 10;
SELECT SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset;
