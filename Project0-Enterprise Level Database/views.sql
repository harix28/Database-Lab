CREATE OR REPLACE VIEW vw_customer_master AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.city,
    r.region_name,
    r.country
FROM customers c
JOIN regions r ON c.region_id = r.region_id;

CREATE OR REPLACE VIEW vw_product_master AS
SELECT 
    p.product_id,
    p.product_name,
    cat.category_name,
    p.unit_price
FROM products p
JOIN categories cat ON p.category_id = cat.category_id;

CREATE OR REPLACE VIEW vw_store_master AS
SELECT 
    s.store_id,
    s.store_name,
    r.region_name
FROM stores s
JOIN regions r ON s.region_id = r.region_id;

CREATE OR REPLACE VIEW vw_employee_master AS
SELECT 
    e.employee_id,
    e.employee_name,
    e.role,
    s.store_name
FROM employees e
JOIN stores s ON e.store_id = s.store_id;


CREATE OR REPLACE VIEW vw_order_header AS
SELECT 
    o.order_id,
    o.order_date,
    o.order_status,
    c.customer_name,
    s.store_name,
    e.employee_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN stores s ON o.store_id = s.store_id
JOIN employees e ON o.employee_id = e.employee_id;

CREATE OR REPLACE VIEW vw_order_line AS
SELECT 
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS line_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

CREATE OR REPLACE VIEW vw_payment_details AS
SELECT 
    p.payment_id,
    p.order_id,
    p.payment_mode,
    p.payment_amount,
    p.payment_date
FROM payments p;


CREATE OR REPLACE VIEW vw_sales_fact AS
SELECT 
    o.order_id,
    o.order_date,
    c.customer_id,
    c.customer_name,
    c.customer_type,
    s.store_id,
    s.store_name,
    r.region_name,
    p.product_id,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS sales_amount,
    pay.payment_mode
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN stores s ON o.store_id = s.store_id
JOIN regions r ON s.region_id = r.region_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
JOIN payments pay ON o.order_id = pay.order_id;


CREATE OR REPLACE VIEW vw_daily_sales AS
    SELECT 
        DATE(o.order_date) AS sales_date,
        SUM(oi.quantity * oi.price) AS total_sales
    FROM
        orders o
            JOIN
        order_items oi ON o.order_id = oi.order_id
    GROUP BY sales_date;
    
CREATE OR REPLACE VIEW vw_customer_revenue AS
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

CREATE OR REPLACE VIEW vw_store_performance AS
SELECT 
    s.store_id,
    s.store_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.price) AS revenue
FROM stores s
JOIN orders o ON s.store_id = o.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_id, s.store_name;

CREATE OR REPLACE VIEW vw_top_customers AS
SELECT *
FROM vw_customer_revenue
ORDER BY total_revenue DESC
LIMIT 20;

CREATE OR REPLACE VIEW vw_category_sales AS
SELECT 
    cat.category_name,
    SUM(oi.quantity * oi.price) AS category_sales
FROM categories cat
JOIN products p ON cat.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY cat.category_name;

