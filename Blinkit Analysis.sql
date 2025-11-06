-- ==========================================================
-- Blinkit Sales performance analysis across Product and Outles using MySQL
-- Description about the dataaset.
-- Blikit Sales dataset which consists of a total of 8524 rows. There are 3 tables naming: -
-- 1. Item with columns Item_ID, Item_Type, Item_Category, Item_Visibility, Visibility_Band, Item_Weight, Item_Fat_Content, Sales_Per_Weight, High_Rated_Item, Rating
-- 2. Sales with columns Sales_ID, Item_ID, Outlet_ID, Sales
-- 3. Outlet with columns Outlet_ID, Outlet_Location_Type, Outlet_Size, Outlet_Age, Outlet_Type, Outlet_Establishment_Year

-- The dataset is a many-to-many type, where Item table has primary key - Item_ID, Sales table has primary key - Sales_ID, and Outlet table has primary key - Outlet_ID.alter

-- Problem statement
-- "Analyze Blinkit's sales performance across different products 
-- and outlets to identify key factors that drive sales, 
-- optimize product placement, and recommend strategies for outlet expansion."

use Blinkitdb;

-- ==========================================================
-- Section 1 - Key Business Metrics
-- ==========================================================

-- Revenue Contribution % by Outlet
SELECT 
    o.Outlet_ID,
    o.Outlet_Type,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(100 * SUM(s.Sales) / (SELECT SUM(Sales) FROM Sales), 2) AS Revenue_Percentage
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_ID, o.Outlet_Type
ORDER BY 
    Revenue_Percentage DESC;
    
-- Average Number of Items Sold per Outlet
SELECT 
    o.Outlet_ID,
    COUNT(s.Item_ID) AS Total_Items_Sold,
    ROUND(AVG(s.Sales), 2) AS Avg_Sale_Per_Item
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_ID
ORDER BY 
    Total_Items_Sold DESC;
    
-- Sales Stability Index
SELECT 
    o.Outlet_ID,
    ROUND(STDDEV(s.Sales) / AVG(s.Sales), 2) AS Sales_Stability_Index
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_ID
ORDER BY 
    Sales_Stability_Index ASC;
    
-- High-Value Item Ratio
SELECT 
    o.Outlet_ID,
    ROUND(100 * SUM(CASE WHEN s.Sales > (SELECT AVG(Sales) FROM Sales) THEN 1 ELSE 0 END) / COUNT(*), 2) AS High_Value_Item_Ratio
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_ID
ORDER BY 
    High_Value_Item_Ratio DESC;
    
-- Sales per Outlet Age
SELECT 
    o.Outlet_ID,
    o.Outlet_Establishment_Year,
    (YEAR(CURDATE()) - o.Outlet_Establishment_Year) AS Outlet_Age,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(SUM(s.Sales) / (YEAR(CURDATE()) - o.Outlet_Establishment_Year + 1), 2) AS Sales_Per_Year
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_ID, o.Outlet_Establishment_Year
ORDER BY 
    Sales_Per_Year DESC;

-- ==========================================================
-- Section 2 - Sales Performance
-- ==========================================================

-- 1. What is the total sales revenue across all outlets?
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales_Revenue
FROM 
    Sales;

-- 1201650

-- 2. Which outlet has the highest total sales?
SELECT 
    s.Outlet_ID,
    ROUND(SUM(s.Sales), 2) AS Total_Sales
FROM 
    Sales s
GROUP BY 
    s.Outlet_ID
ORDER BY 
    Total_Sales DESC;
    
-- 3. Find the top 10 best-selling items by revenue.
SELECT 
    s.Item_ID,
    i.Item_Type,
    i.Item_Category,
    ROUND(SUM(s.Sales), 2) AS Total_Revenue
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
GROUP BY 
    s.Item_ID, i.Item_Type, i.Item_Category
ORDER BY 
    Total_Revenue DESC
LIMIT 10;

-- 4. What is the average sales per item type?
SELECT 
    i.Item_Type,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
GROUP BY 
    i.Item_Type
ORDER BY 
    Avg_Sales DESC;

-- 5. Compare sales between Regular vs Low Fat items
SELECT 
    i.Item_Fat_Content,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
GROUP BY 
    i.Item_Fat_Content
ORDER BY 
    Total_Sales DESC;
    
-- ==========================================================
-- Section 3 - Outlet Analysis
-- ==========================================================

-- 6. Rank outlets by average sales per item
SELECT 
    s.Outlet_ID,
    o.Outlet_Type,
    o.Outlet_Location_Type,
    o.Outlet_Size,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    s.Outlet_ID, o.Outlet_Type, o.Outlet_Location_Type, o.Outlet_Size
ORDER BY 
    Avg_Sales_Per_Item DESC;
    
-- 7. Which outlet type generates the highest revenue?
SELECT 
    o.Outlet_Type,
    ROUND(SUM(s.Sales), 2) AS Total_Revenue
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_Type
ORDER BY 
    Total_Revenue DESC;
    
-- 8. Compare sales performance across Outlet Location Type
SELECT 
    o.Outlet_Location_Type,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_Location_Type
ORDER BY 
    Total_Sales DESC;
    
-- 9. Do larger outlets generate more sales than smaller ones?
SELECT 
    o.Outlet_Size,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_Size
ORDER BY 
    Total_Sales DESC;

-- ==========================================================
-- Section 4 - Item Insights
-- ==========================================================

-- 10. What is the correlation between item visibility band and sales?
SELECT 
    i.Visibility_Band,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
GROUP BY 
    i.Visibility_Band
ORDER BY 
    Total_Sales DESC;
    
-- 11. Find the average rating of items with the highest sales.
SELECT 
    ROUND(AVG(i.Rating), 2) AS Avg_Rating_Top_Selling_Items
FROM 
    Items i
JOIN 
    (
        SELECT 
            Item_ID
        FROM 
            Sales
        GROUP BY 
            Item_ID
        ORDER BY 
            SUM(Sales) DESC
        LIMIT 10
    ) AS top_items 
ON i.Item_ID = top_items.Item_ID;

-- 12. Which item categories contribute the most revenue?
SELECT 
    i.Item_Category,
    ROUND(SUM(s.Sales), 2) AS Total_Revenue,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
GROUP BY 
    i.Item_Category
ORDER BY 
    Total_Revenue DESC;
    
-- 13. Compare sales per weight unit across different item categories.
SELECT 
    i.Item_Category,
    ROUND(SUM(s.Sales) / SUM(i.Item_Weight), 2) AS Sales_Per_Weight_Unit
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
WHERE 
    i.Item_Weight > 0
GROUP BY 
    i.Item_Category
ORDER BY 
    Sales_Per_Weight_Unit DESC;
    
-- ==========================================================
-- Section 5 - Item Insights
-- ==========================================================

-- 14. How do older outlets perform compared to newer ones?
SELECT 
    o.Outlet_Establishment_Year,
    ROUND(SUM(s.Sales), 2) AS Total_Sales,
    ROUND(AVG(s.Sales), 2) AS Avg_Sales_Per_Item
FROM 
    Sales s
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    o.Outlet_Establishment_Year
ORDER BY 
    o.Outlet_Establishment_Year ASC;
    
-- 15. Create a category-outlet matrix: show total sales of each item category across each outlet type.
SELECT 
    i.Item_Category,
    o.Outlet_Type,
    ROUND(SUM(s.Sales), 2) AS Total_Sales
FROM 
    Sales s
JOIN 
    Items i ON s.Item_ID = i.Item_ID
JOIN 
    Outlet o ON s.Outlet_ID = o.Outlet_ID
GROUP BY 
    i.Item_Category, o.Outlet_Type
ORDER BY 
    i.Item_Category, Total_Sales DESC;












 


