-- Using a single CTE, calculate the total revenue per customer across all their orders (all statuses). 
-- From the outer query, return only the top 10 customers by revenue. Display customer_id, full name, city, 
-- and total_revenue rounded to 2 dp.

WITH customer_revenue AS (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.city,
    ROUND(cr.total_revenue, 2) AS total_revenue
FROM customer_revenue cr
JOIN customers c
    ON cr.customer_id = c.customer_id
ORDER BY cr.total_revenue DESC
LIMIT 10;
	