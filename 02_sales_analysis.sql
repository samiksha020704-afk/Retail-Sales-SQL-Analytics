SELECT 
ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments_dataset;
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM olist_orders_dataset;
SELECT 
ROUND(AVG(payment_value),2) AS avg_order_value
FROM olist_order_payments_dataset;
SELECT payment_type,
       ROUND(SUM(payment_value),2) AS revenue
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY revenue DESC;
SELECT order_status,
       COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;
SELECT 
DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS month,
COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY month
ORDER BY month;
SELECT 
DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
ROUND(SUM(p.payment_value),2) AS revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;
SELECT order_id,
       ROUND(SUM(payment_value),2) AS revenue
FROM olist_order_payments_dataset
GROUP BY order_id
ORDER BY revenue DESC
LIMIT 10;