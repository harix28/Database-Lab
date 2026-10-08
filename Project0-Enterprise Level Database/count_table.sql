USE enterprise_sales_db;

SELECT 'categories'   AS table_name, COUNT(*) AS row_count FROM categories
UNION ALL
SELECT 'customers'    AS table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'employees'    AS table_name, COUNT(*) FROM employees
UNION ALL
SELECT 'order_items'  AS table_name, COUNT(*) FROM order_items
UNION ALL
SELECT 'orders'       AS table_name, COUNT(*) FROM orders
UNION ALL
SELECT 'payments'     AS table_name, COUNT(*) FROM payments
UNION ALL
SELECT 'products'     AS table_name, COUNT(*) FROM products
UNION ALL
SELECT 'regions'      AS table_name, COUNT(*) FROM regions
UNION ALL
SELECT 'stores'       AS table_name, COUNT(*) FROM stores;
