-- Question 5: Do larger orders have a higher or lower reorder rate than 
-- smaller orders -- do stock-up trips behave differently from quick 
-- top-up orders?
-- Basket size cutoffs (5, 15, 30) chosen based on the EDA histogram, 
-- which peaked around 4-9 items and thinned out sharply past ~25-30.

SELECT 
    CASE 
        WHEN item_counts.basket_size <= 5 THEN '1_small (1-5 items)'
        WHEN item_counts.basket_size <= 15 THEN '2_medium (6-15 items)'
        WHEN item_counts.basket_size <= 30 THEN '3_large (16-30 items)'
        ELSE '4_very_large (31+ items)'
    END AS basket_size_group,
    COUNT(DISTINCT op.order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    ROUND(AVG(op.reordered)::numeric, 3) AS reorder_rate
FROM order_products_prior op
JOIN (
    SELECT order_id, COUNT(*) AS basket_size
    FROM order_products_prior
    GROUP BY order_id
) item_counts ON op.order_id = item_counts.order_id
GROUP BY basket_size_group
ORDER BY basket_size_group;

-- Result: a U-shape, not a straight line
--   small (1-5):        62.2% -- targeted restocking of known essentials
--   medium (6-15):       58.0% -- the "discovery zone" -- room for both 
--                                 staples and new/exploratory items
--   large (16-30):       58.9%
--   very_large (31+):    61.1% -- genuine stock-up trips, bulk-buying 
--                                 known staples pushes reorder rate back up
--
-- Takeaway: order size and reorder rate reflect two different shopping 
-- missions, not one linear trend. Medium baskets are where cross-sell/
-- promotion has the most room to work, since customers are already 
-- browsing beyond their known list.
