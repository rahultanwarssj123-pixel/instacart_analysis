-- Question 4: Which departments show high order frequency but low reorder 
-- rate (impulse/one-off) vs. low frequency but high reorder rate 
-- (staple/anchor)? What does this suggest for cross-selling/bundling?

SELECT 
    d.department,
    COUNT(*) AS total_order_items,
    ROUND(AVG(op.reordered)::numeric, 3) AS reorder_rate
FROM order_products_prior op
JOIN products p ON op.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY total_order_items DESC;

-- Results classified against the 59% overall baseline:
--
-- Powerhouse (high volume + high reorder rate):
--   produce (9.48M items, 65.0%), dairy eggs (5.41M, 67.0%), 
--   beverages (2.69M, 65.3%) -- retention engine, protect stock/loyalty focus
--
-- Impulse/one-off (high volume + below-baseline reorder rate):
--   snacks (2.89M, 57.4%), frozen (2.24M, 54.2%), 
--   pantry (1.88M, 34.7% -- sharpest contrast in the dataset)
--   -- good targets for cross-promotion / discovery-driven recommendations
--
-- Low-volume, low-reorder (longer replenishment cycle items):
--   personal care (447K, 32.1%), household (739K, 40.2%)
--   -- naturally infrequent within this dataset's order-window snapshot