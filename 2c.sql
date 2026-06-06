-- Across all rows in order_items, calculate: the total revenue generated, the average revenue per line 
-- item, the maximum revenue from a single line item, and the minimum revenue from a single line item. 
-- Round all values to 2 decimal places and label each column clearly. 

SELECT  ROUND(SUM((quantity * unit_price)*(1-discount/100.0)),2) AS total_revenue,
		ROUND(AVG((quantity * unit_price)*(1-discount/100.0)),2) AS avg_revenue,
		ROUND(MAX((quantity * unit_price)*(1-discount/100.0)),2) AS max_revenue,
		ROUND(MIN((quantity * unit_price)*(1-discount/100.0)),2) AS min_revenue

FROM order_items
