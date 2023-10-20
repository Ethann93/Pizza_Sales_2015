SELECT * FROM pizza_sales

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales

SELECT SUM(quantity) AS Total_Pizza_sold 
FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

SELECT CAST( 
CAST(SUM (quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL (10,2))
AS Average_Pizza_Sales 
from pizza_sales

--Hourly Trend for Total Pizzas Sold

SELECT DATEPART(HOUR, order_time) AS Order_Hour, 
SUM(quantity) AS Total_Pizzas_Sold
FROM  pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--Weelky Trend for Total Orders

SELECT DATEPART(ISO_WEEK, order_date) AS Week_Number, 
YEAR(order_date) AS Order_Year, 
COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY  DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

-- Percentage of Total Sales by Pizza Catagory (Year)

SELECT pizza_category, SUM(total_price) AS Total_Sales,
SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS Percentage_Total_Sales
FROM pizza_sales
GROUP BY pizza_category


-- Percentage of Total Sales by Pizza Catagory (By Month)

SELECT pizza_category, SUM(total_price) AS Total_Sales,
SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 3) AS Percentage_Total_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 3
GROUP BY pizza_category

-- Percentage of Total Sales by Pizza Catagory (Quarterly)

SELECT pizza_category, SUM(total_price) AS Total_Sales,
SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 2) AS Percentage_Total_Sales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 2
GROUP BY pizza_category

--Percentage of sales by pizza size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage_Total_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_Total_Sales DESC

--Percentage of sales by pizza size (Quartely)

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 2) 
AS DECIMAL(10,2)) AS Percentage_Total_Sales
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 2
GROUP BY pizza_size
ORDER BY Percentage_Total_Sales DESC

--Percentage of sales by pizza size (Monthly)

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 3) 
AS DECIMAL(10,2)) AS Percentage_Total_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 3
GROUP BY pizza_size
ORDER BY Percentage_Total_Sales DESC

--Top 5 Best sellers by Revenue

SELECT top 5 pizza_name, SUM(total_price) AS Total_Revenue  
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC

--bottom 5 sellers by Revenue

SELECT top 5 pizza_name, SUM(total_price) AS Total_Revenue  
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue ASC

--Top 5 Best sellers by Total Quantity 

SELECT top 5 pizza_name, SUM(quantity) AS Total_Quantity  
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity DESC

--bottom 5 sellers by Total Quantity 

SELECT top 5 pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Quantity ASC


--Top 5 Best sellers by Total Orders

SELECT top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Order  
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Order DESC

--bottom 5 sellers by Total Orders

SELECT top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Order  
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Order ASC