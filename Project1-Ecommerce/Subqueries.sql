-- ============================================================
-- SECTION 5: SUBQUERIES & CTEs
-- ============================================================

-- Q10: Products priced above the average product price
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;

-- Q11: CTE — Customer lifetime value with order count
WITH customer_stats AS (
    SELECT 
        c.customer_id,
        c.full_name,
        c.country,
        COUNT(DISTINCT o.order_id)            AS total_orders,
        SUM(oi.quantity * oi.unit_price)       AS lifetime_value
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.full_name, c.country
)
SELECT *, 
       ROUND(lifetime_value / total_orders, 2) AS avg_order_value
FROM customer_stats
ORDER BY lifetime_value DESC;

-- Q12: CTE — Best-selling product per category
WITH ranked_products AS (
    SELECT 
        c.category_name,
        p.product_name,
        SUM(oi.quantity) AS units_sold,
        RANK() OVER (PARTITION BY c.category_name ORDER BY SUM(oi.quantity) DESC) AS rnk
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
    GROUP BY c.category_name, p.product_name
)
SELECT category_name, product_name, units_sold
FROM ranked_products
WHERE rnk = 1;

