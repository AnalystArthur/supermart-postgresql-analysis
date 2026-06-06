-- Using two chained CTEs, analyse monthly performance for the year 2023 only: 

WITH monthly_revenue AS
(
	SELECT
		EXTRACT(MONTH FROM o.order_date) AS month,
		SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS monthly_revenue

	FROM orders o
	JOIN order_items oi
		ON o.order_id = oi.order_id
	WHERE EXTRACT(YEAR FROM o.order_date) = 2023
	GROUP BY EXTRACT (MONTH FROM o.order_date)
),

monthly_average AS
(
	SELECT
		AVG (monthly_revenue) AS monthly_avg

	FROM monthly_revenue
)

SELECT
	mr.month,
	ROUND (mr.monthly_revenue,2) monthly_revenue,
	CASE 
		WHEN mr.monthly_revenue > ma.monthly_avg THEN 'AboveAverage'
		WHEN mr.monthly_revenue < ma.monthly_avg THEN 'BelowAverage' 
		ELSE 'EqualAverage'
	END AS vs_average
FROM monthly_revenue mr
CROSS JOIN monthly_average ma
ORDER BY mr.month ASC;
