SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset;
SELECT customer_state,
       COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;
SELECT customer_city,
       COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;
SELECT 
c.customer_unique_id,
COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;
SELECT 
c.customer_unique_id,
ROUND(SUM(p.payment_value),2) AS customer_lifetime_value
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY customer_lifetime_value DESC
LIMIT 10;
SELECT 
ROUND(AVG(customer_total),2) AS avg_customer_spending
FROM
(
SELECT 
c.customer_unique_id,
SUM(p.payment_value) AS customer_total
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
) t;
SELECT
CASE
WHEN total_orders = 1 THEN 'One-Time'
ELSE 'Repeat'
END AS customer_type,
COUNT(*) AS customers
FROM
(
SELECT 
c.customer_unique_id,
COUNT(o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
) t
GROUP BY customer_type;
