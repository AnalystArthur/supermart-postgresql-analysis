-- Find all customers whose total lifetime revenue exceeds the average lifetime revenue across all ordering customers. 
-- Display their full name, city, and total revenue (rounded to 2 dp). Order by total revenue descending.

SELECT
    c.first_name || ' ' || c.last_name AS full_name,
    c.city,
    ROUND(cr.total_revenue, 2) AS total_revenue
FROM customers c
JOIN
(
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) cr
    ON c.customer_id = cr.customer_id
WHERE cr.total_revenue >
(
    SELECT AVG(customer_revenue.total_revenue)
    FROM
    (
        SELECT
            o.customer_id,
            SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS total_revenue
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) customer_revenue
)
ORDER BY total_revenue DESC;
