-- ============================================================
-- SECTION 6: WINDOW FUNCTIONS
-- ============================================================

-- Q13: Running total revenue over time
SELECT 
    o.order_date,
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_revenue,
    SUM(SUM(oi.quantity * oi.unit_price)) 
        OVER (ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY o.order_date, o.order_id
ORDER BY o.order_date;

-- Q14: Rank customers by total spend using DENSE_RANK
SELECT 
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    DENSE_RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS spend_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name;

-- Q15: Month-over-month revenue growth
WITH monthly AS (
    SELECT 
        TO_CHAR(o.order_date, 'YYYY-MM') AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month)  AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month)) 
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0) * 100, 2
    ) AS growth_pct
FROM monthly
ORDER BY month;

