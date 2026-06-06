-- Management also wants to understand customer purchasing behaviour over the lifetime of the business.

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        EXTRACT(YEAR FROM c.registration_date) AS registration_year,
        COUNT(o.order_id) AS total_orders,
        COUNT(CASE WHEN o.status = 'Delivered' THEN 1 END) AS delivered_orders,
        COUNT(CASE WHEN o.status = 'Cancelled' THEN 1 END) AS cancelled_orders,
        SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)
                ELSE 0
            END
        ) AS lifetime_revenue
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE c.registration_date < '2024-01-01'
    GROUP BY c.customer_id
)

SELECT
    customer_name,
    city,
    registration_year,
    total_orders,
    delivered_orders,
    cancelled_orders,
    ROUND(COALESCE(lifetime_revenue, 0), 2) AS lifetime_revenue,
    ROUND(
        CASE
            WHEN delivered_orders > 0
            THEN COALESCE(lifetime_revenue, 0) / delivered_orders
            ELSE 0
        END,
        2
    ) AS avg_order_value,
    CASE
        WHEN COALESCE(lifetime_revenue, 0) > 500000
             AND delivered_orders >= 5 THEN 'VIP'
        WHEN COALESCE(lifetime_revenue, 0) BETWEEN 100000 AND 500000
             OR delivered_orders BETWEEN 2 AND 4 THEN 'Loyal'
        WHEN delivered_orders = 1 THEN 'One-Time Buyer'
        WHEN delivered_orders = 0 AND total_orders >= 1 THEN 'No Conversions'
        WHEN total_orders = 0 THEN 'Inactive'
    END AS customer_segment
FROM customer_metrics
ORDER BY lifetime_revenue DESC, customer_name ASC;