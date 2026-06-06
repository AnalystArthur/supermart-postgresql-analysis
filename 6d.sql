-- Using a single query with CASE inside an aggregate, count how many products in each category fall 
-- into each price tier. Display one row per category with columns: category_name, budget_count, 
-- mid_range_count, premium_count. 

SELECT
    c.category_name,
    SUM(
        CASE
            WHEN p.unit_price < 10000 THEN 1
            ELSE 0
        END
    ) AS budget_count,
    SUM(
        CASE
            WHEN p.unit_price BETWEEN 10000 AND 99999 THEN 1
            ELSE 0
        END
    ) AS mid_range_count,
    SUM(
        CASE
            WHEN p.unit_price >= 100000 THEN 1
            ELSE 0
        END
    ) AS premium_count
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY c.category_name;
		