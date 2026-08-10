-- Question 3: How does reorder rate and basket composition differ 
-- between new (early order_number) vs. long-tenured customers?
-- Uses order_products_prior only (not combined with train) to keep 
-- tenure comparison consistent across all users.

-- Tenure buckets: 
--   early = orders 1-3 (still exploring, hasn't had chance to reorder much)
--   developing = orders 4-10 (habits forming)
--   established = orders 11+ (average user has ~16.6 total orders, so this
--   represents genuinely loyal, settled customers)


-- Part 1: Reorder rate by tenure stage
SELECT 
    CASE 
        WHEN o.order_number <= 3 THEN '1_early (orders 1-3)'
        WHEN o.order_number <= 10 THEN '2_developing (orders 4-10)'
        ELSE '3_established (orders 11+)'
    END AS tenure_stage,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    ROUND(AVG(op.reordered)::numeric, 3) AS reorder_rate
FROM orders o
JOIN order_products_prior op ON o.order_id = op.order_id
GROUP BY tenure_stage
ORDER BY tenure_stage;

-- Result: reorder rate climbs sharply with tenure
-- early: 21.9% -> developing: 55.2% -> established: 74.9%
-- Biggest jump happens between early and developing stages.


-- Part 2: Average basket size by tenure stage
SELECT 
    CASE 
        WHEN o.order_number <= 3 THEN '1_early (orders 1-3)'
        WHEN o.order_number <= 10 THEN '2_developing (orders 4-10)'
        ELSE '3_established (orders 11+)'
    END AS tenure_stage,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(item_counts.basket_size)::numeric, 2) AS avg_basket_size
FROM orders o
JOIN (
    SELECT order_id, COUNT(*) AS basket_size
    FROM order_products_prior
    GROUP BY order_id
) item_counts ON o.order_id = item_counts.order_id
GROUP BY tenure_stage
ORDER BY tenure_stage;

-- Result: basket size stays nearly flat across tenure
-- early: 9.99 -> developing: 10.05 -> established: 10.15
-- Takeaway: loyalty shows up as buying the SAME things again,
-- not buying MORE per order. Growth comes from retention/frequency,
-- not basket-size upsell.