-- Show all 35 employees with their full_name, role, region_name (from the regions table), and the 
-- total number of orders they have handled. Include employees with zero orders (show 0). Order by total 
-- orders descending, then last_name ascending. 

SELECT  e.first_name||' '||e.last_name AS full_name,
		e.role,
		r.region_name,
		COUNT (o.order_id) AS total_orders
FROM employees e
JOIN regions r
	ON e.region_id = r.region_id
LEFT JOIN orders o
	ON e.employee_id = o.employee_id
GROUP BY e.employee_id,
		 e.first_name||' '||e.last_name,
		 e.last_name,
		 e.role,
		 r.region_name
ORDER BY total_orders DESC, e.last_name ASC;