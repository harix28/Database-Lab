
-- ============================================================
-- SECTION 7: VIEWS (Reusable Analytical Layers)
-- ============================================================

-- View 1: Enriched order details
CREATE VIEW vw_order_details AS
SELECT 
    o.order_id,
    o.order_date,
    o.status,
    c.full_name       AS customer_name,
    c.country,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total
FROM orders o
JOIN customers c    ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p     ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id;

-- View 2: Customer summary dashboard
CREATE VIEW vw_customer_summary AS
SELECT 
    c.customer_id,
    c.full_name,
    c.country,
    c.signup_date,
    COUNT(DISTINCT o.order_id)      AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    MAX(o.order_date)                AS last_order_date
FROM customers c
LEFT JOIN orders o     ON c.customer_id = o.customer_id AND o.status = 'completed'
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name, c.country, c.signup_date;

-- View 3: Product performance
CREATE VIEW vw_product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    cat.category_name,
    p.price,
    p.stock_quantity,
    SUM(oi.quantity)                  AS total_units_sold,
    SUM(oi.quantity * oi.unit_price)  AS total_revenue
FROM products p
JOIN categories cat ON p.category_id = cat.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status = 'completed'
GROUP BY p.product_id, p.product_name, cat.category_name, p.price, p.stock_quantity;


