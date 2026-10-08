-- ============================================================
-- SECTION 3: BASIC QUERIES
-- ============================================================

-- Q1: List all products with their category name
SELECT p.product_name, c.category_name, p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY c.category_name;

-- Q2: All completed orders with customer name and order date
SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
ORDER BY o.order_date;

-- Q3: Total items sold per product
SELECT p.product_name, SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;
