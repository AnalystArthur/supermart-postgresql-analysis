-- List all 800 customers alongside the total number of orders they have placed. Customers who have 
-- never ordered should show 0. Display customer_id, full name, city, and order_count. Order by 
-- order_count descending, then last_name ascending.

SELECT  c.customer_id,
		c.first_name||' '||c.last_name AS full_name,
		c.city,
		COUNT (o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC, last_name ASC;
