-- ============================================================
-- Retail Business Performance & Profitability Analysis
-- SQL Queries (T-SQL / SSMS compatible)
-- Table: SuperstoreSales  (import superstore_cleaned.csv)
-- ============================================================

-- 1. Handle missing / null records (run BEFORE analysis, on raw import)
-- Example: fill missing Product Base Margin with category median
UPDATE SuperstoreSales
SET [Product Base Margin] = (
    SELECT AVG(s2.[Product Base Margin])
    FROM SuperstoreSales s2
    WHERE s2.[Product Category] = SuperstoreSales.[Product Category]
)
WHERE [Product Base Margin] IS NULL;

-- ============================================================
-- 2. Profit Margin % by Category
-- ============================================================
SELECT
    [Product Category] AS Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin_Pct
FROM SuperstoreSales
GROUP BY [Product Category]
ORDER BY Profit_Margin_Pct DESC;

-- ============================================================
-- 3. Profit Margin % by Sub-Category (bottom 10 -> loss drivers)
-- ============================================================
SELECT TOP 10
    [Product Category] AS Category,
    [Product Sub-Category] AS Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin_Pct
FROM SuperstoreSales
GROUP BY [Product Category], [Product Sub-Category]
ORDER BY Profit_Margin_Pct ASC;

-- ============================================================
-- 4. Profit Margin % by Region
-- ============================================================
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / SUM(Sales), 2) AS Profit_Margin_Pct
FROM SuperstoreSales
GROUP BY Region
ORDER BY Profit_Margin_Pct DESC;

-- ============================================================
-- 5. Seasonal Sales Trend by Category
--    (Season derived from Order Date month)
-- ============================================================
SELECT
    CASE
        WHEN MONTH([Order Date]) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH([Order Date]) IN (3, 4, 5)  THEN 'Spring'
        WHEN MONTH([Order Date]) IN (6, 7, 8)  THEN 'Summer'
        ELSE 'Fall'
    END AS Season,
    [Product Category] AS Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(DATEDIFF(day, [Order Date], [Ship Date])), 2) AS Avg_Days_To_Ship
FROM SuperstoreSales
GROUP BY
    CASE
        WHEN MONTH([Order Date]) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH([Order Date]) IN (3, 4, 5)  THEN 'Spring'
        WHEN MONTH([Order Date]) IN (6, 7, 8)  THEN 'Summer'
        ELSE 'Fall'
    END,
    [Product Category]
ORDER BY Season, Total_Sales DESC;

-- ============================================================
-- 6. Top 5 Sub-Categories Driving Losses (overstocked / underperforming)
-- ============================================================
SELECT TOP 5
    [Product Sub-Category] AS Sub_Category,
    COUNT(*) AS Num_Orders,
    ROUND(SUM(Profit), 2) AS Total_Loss
FROM SuperstoreSales
WHERE Profit < 0
GROUP BY [Product Sub-Category]
ORDER BY Total_Loss ASC;
