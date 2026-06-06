-- For each year in the dataset (2021–2024), show the total number of orders placed and the count of 
-- distinct customers who ordered that year. Order by year ascending. 
SELECT EXTRACT (YEAR FROM order_date) AS year,
		COUNT (*) AS total_orders,
		COUNT (DISTINCT(customer_id)) AS distinct_customers
		
FROM orders
GROUP BY EXTRACT (YEAR FROM order_date)
ORDER BY year;