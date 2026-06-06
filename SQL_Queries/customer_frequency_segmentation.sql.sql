--  Calculate how many total orders  each customer has placed, then classify each customer


WITH customer_order_counts AS (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)

SELECT
    CASE
        WHEN total_orders >= 8 THEN 'High Frequency'
        WHEN total_orders BETWEEN 4 AND 7 THEN 'Regular'
        WHEN total_orders BETWEEN 1 AND 3 THEN 'Occasional'
        WHEN total_orders = 0 THEN 'Inactive'
    END AS segment_label,
    COUNT(*) AS customer_count
FROM customer_order_counts
GROUP BY segment_label
ORDER BY customer_count DESC;
