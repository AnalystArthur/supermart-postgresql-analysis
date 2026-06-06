-- Using a CTE, compute the year-over-year total revenue from delivered orders for each year in the  dataset (2021, 2022, 2023, and the first half of 2024). Display order_year and total_revenue (rounded to 2 dp). Order by year ascending. 

WITH delivered_revenue AS (
    SELECT
        EXTRACT(YEAR FROM o.order_date) AS order_year,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY EXTRACT(YEAR FROM o.order_date)
)

SELECT
    order_year,
    ROUND(total_revenue, 2) AS total_revenue
FROM delivered_revenue
ORDER BY order_year ASC;
