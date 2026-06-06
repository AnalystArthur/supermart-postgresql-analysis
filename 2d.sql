-- How many distinct customers have placed at least one order? What is the average number of orders 
-- per ordering customer, rounded to 2 decimal places? Display both figures as separate columns in a 
-- single result row.

SELECT COUNT (DISTINCT (customer_id)) AS distinct_customers,
		ROUND (COUNT (*)*1.0/COUNT (DISTINCT (customer_id)),2) avg_orders
FROM orders;