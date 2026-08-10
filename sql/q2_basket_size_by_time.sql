-- Question 2: Does average basket size vary by day of week or hour of day?

-- Detailed view: basket size by day AND hour
SELECT 
    o.order_dow,
    o.order_hour_of_day,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(item_counts.basket_size)::numeric, 2) AS avg_basket_size
FROM orders o
JOIN (
    SELECT order_id, COUNT(*) AS basket_size
    FROM order_products_prior
    GROUP BY order_id
) item_counts ON o.order_id = item_counts.order_id
GROUP BY o.order_dow, o.order_hour_of_day
ORDER BY o.order_dow, o.order_hour_of_day;


-- Summary view: basket size by day only (for dashboard/chart use)
SELECT 
    o.order_dow,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(item_counts.basket_size)::numeric, 2) AS avg_basket_size
FROM orders o
JOIN (
    SELECT order_id, COUNT(*) AS basket_size
    FROM order_products_prior
    GROUP BY order_id
) item_counts ON o.order_id = item_counts.order_id
GROUP BY o.order_dow
ORDER BY o.order_dow;