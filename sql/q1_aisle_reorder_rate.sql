-- Question 1: Which aisles have a disproportionately high reorder rate 
-- relative to their order volume?
-- Filtered to aisles with 50k+ order-items to avoid small-sample noise.

SELECT 
    a.aisle,
    COUNT(*) AS total_order_items,
    ROUND(AVG(op.reordered)::numeric, 3) AS reorder_rate,
    ROUND((AVG(op.reordered) - 0.59)::numeric, 3) AS diff_from_baseline
FROM order_products_prior op
JOIN products p ON op.product_id = p.product_id
JOIN aisles a ON p.aisle_id = a.aisle_id
GROUP BY a.aisle
HAVING COUNT(*) >= 50000
ORDER BY reorder_rate DESC
LIMIT 20;