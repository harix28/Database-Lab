-- ============================================================
-- SECTION 8: DASHBOARD SUMMARY QUERIES
-- ============================================================

-- KPI 1: Overall business summary
SELECT 
    COUNT(DISTINCT customer_id)                        AS total_customers,
    COUNT(DISTINCT order_id)                           AS total_orders,
    SUM(quantity * unit_price)                         AS gross_revenue,
    ROUND(AVG(quantity * unit_price), 2)               AS avg_order_item_value
FROM vw_order_details
WHERE status = 'completed';

-- KPI 2: Return rate
SELECT 
    COUNT(CASE WHEN status = 'returned'  THEN 1 END)  AS returned_orders,
    COUNT(CASE WHEN status = 'completed' THEN 1 END)  AS completed_orders,
    ROUND(
        COUNT(CASE WHEN status = 'returned' THEN 1 END) * 100.0 / COUNT(*), 2
    ) AS return_rate_pct
FROM orders;

-- KPI 3: Stock alert — products with low inventory
SELECT product_name, category_name, stock_quantity, total_units_sold,
       (stock_quantity - COALESCE(total_units_sold, 0)) AS remaining_stock
FROM vw_product_performance
WHERE stock_quantity < 100
ORDER BY remaining_stock ASC;

-- KPI 4: Country-wise revenue
SELECT c.country,
       COUNT(DISTINCT o.order_id)            AS orders,
       SUM(oi.quantity * oi.unit_price)      AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.country
ORDER BY revenue DESC;

