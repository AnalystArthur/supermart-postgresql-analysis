-- For each product category, list every product alongside the total number of distinct orders it has appeared in and the total quantity sold. 
-- Display category_name, product_name, times_ordered, and total_qty_sold. Order by category_name, then total_qty_sold descending.

SELECT  c.category_name,
		p.product_name,
		COUNT (DISTINCT o.order_id) AS times_ordered,
		SUM (o.quantity) AS total_qty_sold
FROM categories c
JOIN products p
	ON c.category_id = p.category_id
JOIN order_items o
	ON p.product_id = o.product_id
GROUP BY p.product_ID,
		 c.category_name,
		 p.product_name
ORDER BY c.category_name, total_qty_sold DESC;
