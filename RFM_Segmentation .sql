-- Customer Segmentation with RFM Analysis

WITH SalesBase AS(
	SELECT
		c.CustomerKey AS CustomerID,
		fis.SalesOrderNumber AS OrderID,
		d.FullDateAlternateKey AS OrderDate,
		fis.SalesAmount
	FROM [AdventureWorksDW2025].[dbo].[FactInternetSales] fis
	JOIN [AdventureWorksDW2025].[dbo].[DimCustomer] c
		ON fis.CustomerKey = c.CustomerKey
	JOIN [AdventureWorksDW2025].[dbo].[DimDate] d
		ON fis.OrderDateKey = d.DateKey
)


, ReferenceDate AS(
	SELECT MAX(OrderDate) AS RefDate
	FROM SalesBase
)


, RFM_Base AS(
	SELECT
		sb.CustomerID,
		-- Recency: days since last purchase
		DATEDIFF(
			DAY,
			MAX(sb.OrderDate),
			MAX(rd.RefDate)
		) AS Recency,
		 -- Frequency: number of orders
		 COUNT(DISTINCT sb.OrderID) AS Frequency,
		 -- Monetary: total sales amount
		 SUM(sb.SalesAmount) AS Monetary
	FROM SalesBase sb
	CROSS JOIN ReferenceDate rd
	GROUP BY sb.CustomerID
)


, RFM_Scored AS (
    SELECT
        CustomerID,
		Recency,
		Frequency,
		Monetary,

        6 - NTILE(5) OVER (ORDER BY Recency)      AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency)        AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary)         AS M_Score

    FROM RFM_Base
)


SELECT
	CustomerID,
	Recency,
	Frequency,
	Monetary,
	R_Score,
	F_Score,
	M_Score,
	CASE
		-- Customers who purchased recently and purchase frequently
		WHEN R_Score >= 4 AND F_Score >= 4 THEN 'Champions'

		-- Customers who buy regularly, even if their last purchase is not very recent
		WHEN F_Score >= 3 AND M_Score >= 3 THEN 'Loyal Customers'

		-- Customers who purchased recently with medium purchase frequency
		WHEN R_Score >= 3 AND F_Score BETWEEN 2 AND 3 THEN 'Potential Loyalists'

		-- Customers with high recency but low purchase frequency
		WHEN R_Score >= 5 AND F_Score = 1 THEN 'New Customers'

		-- Customers who used to buy frequently (high F) but haven't purchased for a long time (low R)
		WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'

		-- Customers with medium-to-low recency and frequency
		WHEN R_Score = 3 AND F_Score = 3 THEN 'Need Attention'

		-- Customers with low recency and frequency, close to becoming inactive
		WHEN R_Score BETWEEN 2 AND 3 AND F_Score <= 2 THEN 'About To Sleep'

		-- Customers with the lowest scores
		ELSE 'Lost Customers'
		END AS RFM_Segment
FROM RFM_Scored


