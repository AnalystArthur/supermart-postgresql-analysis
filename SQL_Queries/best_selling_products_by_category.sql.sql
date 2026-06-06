-- Single best-selling product (by total quantity sold) in each category.

WITH total_quantity AS (
    SELECT
        oi.product_id,
        SUM(oi.quantity) AS total_qty_sold
    FROM order_items oi
    GROUP BY oi.product_id
),

category_product_sales AS (
    SELECT
        c.category_name,
        p.product_name,
        tq.total_qty_sold
    FROM total_quantity tq
    JOIN products p
        ON tq.product_id = p.product_id
    JOIN categories c
        ON p.category_id = c.category_id
)

SELECT
    category_name,
    product_name,
    total_qty_sold
FROM category_product_sales cps
WHERE total_qty_sold = (
    SELECT MAX(total_qty_sold)
    FROM category_product_sales cps2
    WHERE cps2.category_name = cps.category_name
)
ORDER BY category_name;



