# NORMALIZATION

-- Step 1: Create a temporary table "INV" for data cleaning
	-- Creates a temporary table INV to assign unique employee IDs using DENSE_RANK.


CREATE TABLE INV AS
SELECT 
    DENSE_RANK() OVER (PARTITION BY "" ORDER BY employee_name) AS employee_id,
    employee_name,
    customer_id	
FROM 
    aws_sales;

-- Step 2: Create the employees table
	-- Creates an employees table with unique IDs and renames customer_id to company_id.
	-- Improves data clarity and access.

CREATE TABLE employees AS
SELECT DISTINCT 
    (employee_id + 100) AS employee_id,
    customer_id AS company_id,
    employee_name
FROM 
    INV;
ALTER TABLE `project`.`employees` 
ADD PRIMARY KEY (`employee_id`);

-- Step 3: Create the companies table
	-- Purpose: Extracts unique company information and sets company_id as the primary key.Normalizes company data, making it easier to maintain and query.

CREATE TABLE companies AS
SELECT 
    DISTINCT(company_id),
    company,
    industry
FROM 
    aws_sales
ORDER BY 
    company_id;
ALTER TABLE `project`.`companies` 
CHANGE COLUMN `customer_id` `company_id` INT NOT NULL,
ADD PRIMARY KEY (`company_id`);

-- Step 4: Create the location table
	-- Creates a location table linking orders to employee locations.


CREATE TABLE location AS
SELECT 
    DISTINCT(S.order_id),
    E.employee_id,
    S.country,
    S.city
FROM 
    employees E INNER JOIN aws_sales S 
    ON S.employee = E.employee_name
ORDER BY 
    country;
ALTER TABLE `project`.`location` 
CHANGE COLUMN `order_id` `order_id` TEXT NOT NULL,
ADD PRIMARY KEY (`order_id`);

-- Step 5: Create the order_info table
	-- Purpose: Captures order dates and employee details.

CREATE TABLE order_info AS
SELECT 
    DISTINCT(S.order_id),
    E.employee_id,
    S.order_date
FROM 
    employees E INNER JOIN aws_sales S 
    ON S.employee = E.employee_name;

-- Step 6: Create the sales table
	-- Purpose: Creates a sales table with cleaned sales data.

CREATE TABLE sales AS
SELECT 
    order_id,
    license,
    product,
    sales,
    ABS(quantity) AS quantity,
    discount AS discount_rate,
    ROUND(ABS(profit), 2) AS profit
FROM 
    project.aws_sales;

# DATA CLEANING

-- Change the order date from "MM/DD/YYYY" format to "YYYY-MM-DD" format
-- Converts order dates to "YYYY-MM-DD" format to ensures date consistency and facilitates date-based queries.

UPDATE order_info
SET order_date = STR_TO_DATE(order_date, "%c/%e/%Y");
ALTER TABLE `project`.`order_info` 
CHANGE COLUMN `order_date` `order_date` DATE NULL DEFAULT NULL;

-- Cleaned up the city text with incorrect spellings

UPDATE location
SET city = 'Aichiw2'
WHERE city = 'Aichi';

UPDATE location
SET city = 'S?a paulo'
WHERE city = 'Sao Paulo';

UPDATE location
SET city = 'Malm"'
WHERE city = 'Malm';
