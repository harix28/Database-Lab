-- =================================
-- TOP 10 CUSTOMER
================================= 

DELIMITER //
CREATE PROCEDURE top_customers(IN top_n INT)
BEGIN
    SELECT c.customer_name,
           SUM(oi.quantity * oi.price) AS revenue
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_name
    ORDER BY revenue DESC
    LIMIT top_n;
END //
DELIMITER ;

CALL top_customers(10);



-- =================================
-- MONTHLY SALES SUMMARY
-- ================================= 

DELIMITER //
CREATE PROCEDURE monthly_sales_summary(IN year_input INT)
BEGIN
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
           SUM(oi.quantity * oi.price) AS total_sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE YEAR(order_date) = year_input
    GROUP BY month
    ORDER BY month;
END //
DELIMITER ;



-- =================================
-- PRODUCT SALES REPORT
-- ================================= 

DELIMITER //
CREATE PROCEDURE product_sales_report(IN product_id_input INT)
BEGIN
    SELECT p.product_name,
           SUM(oi.quantity) AS total_quantity_sold,
           SUM(oi.quantity * oi.price) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.product_id = product_id_input
    GROUP BY p.product_name;
END //
DELIMITER ;


-- =================================
-- STORE PERFORMANCE
-- ================================= 

DELIMITER //
CREATE PROCEDURE store_performance(IN store_id_input INT)
BEGIN
    SELECT s.store_name,
           COUNT(DISTINCT o.order_id) AS total_orders,
           SUM(oi.quantity * oi.price) AS total_sales,
           AVG(oi.price) AS avg_order_value
    FROM stores s
    JOIN orders o ON s.store_id = o.store_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE s.store_id = store_id_input
    GROUP BY s.store_name;
END //
DELIMITER ;



