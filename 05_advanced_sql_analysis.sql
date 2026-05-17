WITH customer_spending AS
(
SELECT 
c.customer_state,
c.customer_unique_id,
ROUND(SUM(p.payment_value),2) AS total_spent
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY c.customer_state,
         c.customer_unique_id
),

ranked_customers AS
(
SELECT *,
DENSE_RANK() OVER(
PARTITION BY customer_state
ORDER BY total_spent DESC
) AS rn
FROM customer_spending
)

SELECT *
FROM ranked_customers
WHERE rn <= 5;
WITH category_revenue AS
(
SELECT 
p.product_category_name,
ROUND(SUM(oi.price + oi.freight_value),2) AS revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
)

SELECT *,
DENSE_RANK() OVER(
ORDER BY revenue DESC
) AS revenue_rank
FROM category_revenue;
WITH customer_total AS
(
SELECT 
c.customer_unique_id,
SUM(p.payment_value) AS total_spent
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
)

SELECT *
FROM customer_total
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM customer_total
)
ORDER BY total_spent DESC;
SELECT 
DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS month,
ROUND(SUM(p.payment_value),2) AS revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY month
ORDER BY revenue DESC
LIMIT 5;