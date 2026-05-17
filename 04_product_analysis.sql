SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;
SELECT 
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_orders DESC
LIMIT 10;
SELECT 
    oi.product_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_order_items_dataset oi
GROUP BY oi.product_id
ORDER BY total_revenue DESC
LIMIT 10;
SELECT 
    product_id,
    ROUND(AVG(price), 2) AS avg_price
FROM olist_order_items_dataset
GROUP BY product_id
ORDER BY avg_price DESC
LIMIT 10;
SELECT 
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING total_orders < 50
ORDER BY total_revenue ASC;
