--Revenue 
SELECT ROUND(SUM(o.quantity * p.product_price) :: NUMERIC , 2) AS revenue
FROM orders o 
JOIN product_price p
ON o.product_price = p.product_price);


--Frequency of orders by amount spent
WITH order_revenue AS (
	SELECT
		order_number,
		SUM(o.quantity * p.product_price) AS revenue
	FROM orders o 
	JOIN product_price p
	ON o.product_price = p.product_price
	GROUP BY order_number)

SELECT ROUND(revenue :: NUMERIC, -2) as revenue_100,
COUNT(DISTINCT order_number) as total_orders
FROM order_revenue
GROUP BY revenue_100
ORDER BY revenue_100 ASC;


--Revenue quartiles 
WITH order_revenue AS (
	SELECT
		order_number,
		SUM(o.quantity * p.product_price) AS revenue
	FROM orders o 
	JOIN product_price p
	ON o.product_price = p.product_price
	GROUP BY order_number)

SELECT 
	ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue ASC) :: NUMERIC, 2) AS revenue_p25,
	ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue ASC) :: NUMERIC, 2) AS revenue_p50,
	ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue ASC) :: NUMERIC, 2) AS revenue_p75,
	ROUND(AVG(revenue) :: NUMERIC, 2) AS avg_revenue
FROM order_revenue
