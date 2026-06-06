-- How many orders exist for each status? Display the status, the count, and each status as a 
--percentage of all orders, rounded to 2 decimal places. Label the percentage column pct_of_total. Order 
-- by count descending.

SELECT	status,
		COUNT (*) AS order_count,
		ROUND(
			COUNT (*) * 100.0 / (SELECT COUNT (*) FROM orders), 2) AS pct_of_total
FROM orders
GROUP BY status
ORDER BY order_count DESC;