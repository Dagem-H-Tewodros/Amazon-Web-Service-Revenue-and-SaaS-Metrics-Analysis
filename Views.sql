# Views
	##1. Sales Summary View
		##	Summarizes the key sales data, providing a high-level overview of sales performance.

-- Creating a view to summarize sales data
CREATE VIEW vw_sales_summary AS
SELECT 
    product_id,
    SUM(quantity) AS total_quantity_sold,
    SUM(total_price) AS total_sales_amount,
    AVG(total_price) AS average_sale_price,
    COUNT(order_id) AS total_orders
FROM sales
GROUP BY product_id;

-- This view aggregates the sales data by product ID.
-- It calculates the total quantity sold, total sales amount, average sale price, and the total number of orders for each product.
