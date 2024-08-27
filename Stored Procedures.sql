# Stored Procedures
	## 1.Stored Procedure to Update Product Prices
		## Updates the price of a product based on its product ID.
DELIMITER //

CREATE PROCEDURE sp_update_product_price(IN productID INT, IN newPrice DECIMAL(10,2))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        SELECT 'Error occurred during product price update' AS Error;
    END;

    UPDATE products
    SET price = newPrice
    WHERE product_id = productID;

    -- This procedure takes a product ID and a new price as input parameters.
    -- It updates the price of the specified product.
END //

DELIMITER ;

	## 2.Stored Procedure to Generate Monthly Sales Report
		## Generates a sales report for a specific month.
DELIMITER //

CREATE PROCEDURE sp_generate_monthly_sales_report(IN reportMonth VARCHAR(7))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error
        SELECT 'Error occurred during sales report generation' AS Error;
    END;

    SELECT 
        product_id,
        SUM(quantity) AS total_quantity_sold,
        SUM(total_price) AS total_sales_amount,
        AVG(total_price) AS average_sale_price,
        COUNT(order_id) AS total_orders
    FROM sales
    WHERE DATE_FORMAT(order_date, '%Y-%m') = reportMonth
    GROUP BY product_id;

    -- This procedure generates a sales report for a given month (YYYY-MM format).
    -- It aggregates sales data for the specified month and groups it by product ID.
END //

DELIMITER ;

