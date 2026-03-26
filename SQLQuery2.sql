use blinkitdb
select * from blinkit_data
update blinkit_data
set Item_Fat_Content = 
case 
when Item_Fat_Content IN ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
END

select Distinct (Item_Fat_Content) from blinkit_data

SElECT CAST(SUM(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions
from blinkit_data
WHERE Item_Fat_Content = 'Low Fat'

SELECT CAST(AVG(Sales) AS decimal(10,0)) AS Avg_Sales
from blinkit_data 

SELECT COUNT(*) AS No_of_items
FROM blinkit_data

SELECT CAST(AVG(Rating)AS DECIMAL(10,2)) as Avg_rating 
FROM  blinkit_data

SELECT Item_Fat_Content,CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) as Total_sales_Thousand,
CAST(AVG(Sales) AS DECIMAL(10,2)) as Avg_sales,
COUNT(*) AS No_of_items,
CAST(AVG(Rating)AS DECIMAL(10,2)) as Avg_rating  
From blinkit_data
GROUP by Item_Fat_Content
ORDER BY Total_sales_Thousand  DESC 

SELECT Item_Type,
CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) as Total_sales_Thousand,
CAST(AVG(Sales) AS DECIMAL(10,2)) as Avg_sales,
COUNT(*) AS No_of_items,
CAST(AVG(Rating)AS DECIMAL(10,2)) as Avg_rating 
From blinkit_data
GROUP by Item_Type
ORDER BY Total_sales_Thousand  DESC 

SELECT Outlet_Location_Type,
 ISNULL([Low Fat],0) as Low_Fat,
 ISNULL([Regular],0) as Regular
From
(
SELECT Outlet_Location_Type,Item_Fat_Content,
CAST(SUM(Sales) AS DECIMAL(10,2)) as Total_sales
From blinkit_data
GROUP by Outlet_Location_Type,Item_Fat_Content
) as SourceTable
PIVOT
(
SUM(Total_sales)
FOR Item_Fat_Content IN ([Low Fat],[Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

SELECT Outlet_Establishment_Year,
CAST(SUM(Sales) as DECIMAL(10,2)) AS Total_Sales,
COUNT(*) AS No_of_items,
CAST(AVG(Rating)AS DECIMAL(10,2)) as Avg_rating 
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales  DESC

SELECT Outlet_Size,
CAST(SUM(Sales) as DECIMAL(10,2)) AS Total_Sales,
CAST((SUM(Sales)*100 / SUM(SUM(Sales)) OVER()) as DECIMAL(10,2))
AS Sales_Percentage
FROM blinkit_data
GROUP BY  Outlet_Size

SELECT Outlet_Location_Type,
CAST(SUM(Sales) as DECIMAL(10,2)) AS Total_Sales,
CAST(AVG(Sales) AS DECIMAL(10,2)) as Avg_sales,
CAST((SUM(Sales)*100 / SUM(SUM(Sales)) OVER()) as DECIMAL(10,2))
AS Sales_Percentage,
COUNT(*) AS No_of_items,
CAST(AVG(Rating)AS DECIMAL(10,2)) as Avg_rating 
FROM blinkit_data
GROUP BY  Outlet_Location_Type
ORDER BY Total_Sales DESC

SELECT Outlet_Type,
CAST(SUM(Sales) as DECIMAL(10,2)) AS Total_Sales,
CAST(AVG(Sales) AS DECIMAL(10,2)) as Avg_sales,
CAST((SUM(Sales)*100 / SUM(SUM(Sales)) OVER()) as DECIMAL(10,2))
AS Sales_Percentage,
COUNT(*) AS No_of_items,
CAST(AVG(Rating)AS DECIMAL(10,2)) as Avg_rating 
FROM blinkit_data
GROUP BY  Outlet_Type
ORDER BY Total_Sales DESC

