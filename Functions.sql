# Functions
	## Function to Calculate Discounted Price
		## Calculates the discounted price for a product.
DELIMITER //

CREATE FUNCTION fn_calculate_discounted_price(originalPrice DECIMAL(10,2), discountRate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE discountedPrice DECIMAL(10,2);
    
    SET discountedPrice = originalPrice - (originalPrice * discountRate / 100);
    
    RETURN discountedPrice;

    -- Explanation:
    -- This function calculates the discounted price based on the original price and discount rate.
    -- It returns the discounted price.
END //

DELIMITER ;

	## Function to Calculate Sales Tax
		## Calculates the sales tax for a given amount.
DELIMITER //

CREATE FUNCTION fn_calculate_sales_tax(amount DECIMAL(10,2), taxRate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE salesTax DECIMAL(10,2);
    
    SET salesTax = amount * taxRate / 100;
    
    RETURN salesTax;

    -- Explanation:
    -- This function calculates the sales tax based on the given amount and tax rate.
    -- It returns the calculated sales tax.
END //

DELIMITER ;

	