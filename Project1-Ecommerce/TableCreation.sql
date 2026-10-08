-- ============================================================
--   E-COMMERCE & SALES — FULL SQL DATA ANALYSIS PROJECT
--   Level: Intermediate | Domain: E-Commerce
--   Covers: Schema Design, Sample Data, Joins, Aggregations,
--           Subqueries, Window Functions, Views, CTEs
-- ============================================================

-- ============================================================
-- SECTION 1: SCHEMA DESIGN
-- ============================================================

-- CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    full_name       VARCHAR(100),
    email           VARCHAR(100) UNIQUE,
    city            VARCHAR(50),
    country         VARCHAR(50),
    signup_date     DATE
);

CREATE TABLE categories (
    category_id     INT PRIMARY KEY,
    category_name   VARCHAR(50)
);

CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(100),
    category_id     INT REFERENCES categories(category_id),
    price           DECIMAL(10,2),
    stock_quantity  INT
);

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    order_date      DATE,
    status          VARCHAR(20)   -- 'completed', 'returned', 'pending'
);

CREATE TABLE order_items (
    item_id         INT PRIMARY KEY,
    order_id        INT REFERENCES orders(order_id),
    product_id      INT REFERENCES products(product_id),
    quantity        INT,
    unit_price      DECIMAL(10,2)
);

