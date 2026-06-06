-- Count the number of customers who registered each year between 2018 and 2024. Display the 
-- registration year and the count. Order by year ascending. 

SELECT (EXTRACT (YEAR FROM registration_date)) AS year,
		COUNT (*)
FROM customers
WHERE (EXTRACT (YEAR FROM registration_date)) BETWEEN 2018 AND 2024
GROUP BY year
ORDER BY year ASC;
