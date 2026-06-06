-- Show each employee's full name and the total number of orders they handled. Return only 
-- employees who handled 20 or more orders. Order by order count descending. 

SELECT e.first_name||' '||e.last_name AS full_name,
		COUNT (o.order_id) AS total_orders

FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.employee_id
HAVING COUNT (o.order_id) >= 20
ORDER BY total_orders DESC;