-- ============================================================
-- SECTION 4: INTERMEDIATE QUERIES
-- ============================================================

-- Q4: Total revenue per order (only completed orders)
SELECT o.order_id, c.full_name,
       SUM(oi.quantity * oi.unit_price) AS order_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY o.order_id, c.full_name
ORDER BY order_revenue DESC;

-- Q5: Revenue by product category
SELECT c.category_name,
       SUM(oi.quantity * oi.unit_price) AS total_revenue,
       COUNT(DISTINCT o.order_id) AS total_orders
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- Q6: Top 5 customers by total spend
SELECT c.full_name, c.country,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name, c.country
ORDER BY total_spent DESC
LIMIT 5;

-- Q7: Monthly revenue trend
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    SUM(oi.quantity * oi.unit_price)  AS monthly_revenue,
    COUNT(DISTINCT o.order_id)         AS orders_placed
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY month;

-- Q8: Products never ordered
SELECT p.product_id, p.product_name, p.price
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Q9: Customers with more than 1 order
SELECT c.full_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

