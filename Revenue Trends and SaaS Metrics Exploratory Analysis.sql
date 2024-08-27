 -- AMAZON WEB SERVICES EXPLATORY ANALYSIS AND SaaS ANALYTICS
    
    
    #1. Most Popular Products
		-- Lists the most subscribe to services along with the amount of subscribers.

SELECT 
    product,
    COUNT(product) AS product_subscribers
FROM 
    sales
GROUP BY 
    product
ORDER BY 
    product_subscribers DESC;


	#2. Sales by Country
		-- Identifies high-performing markets to be used in country-specific sales strategies.

SELECT 
    L.country, 
    ROUND(SUM(S.sales), 2) AS total_sales
FROM 
    location L
INNER JOIN 
    sales S ON L.order_id = S.order_id
GROUP BY 
    L.country
ORDER BY 
    total_sales DESC;


	#3. Sales Trend by Quarter
		-- Identifies Quarterly trends in sales.

SELECT 
    YEAR(O.order_date) AS year,
    QUARTER(O.order_date) AS quarter,
    ROUND(SUM(S.sales), 2) AS total_sales
FROM 
    order_info O
INNER JOIN 
    sales S ON O.order_id = S.order_id
GROUP BY 
    year, quarter
ORDER BY 
    year, quarter;


	# 4. Sales and Profit by Product
			-- Evaluates the performance of each service provided in terms of sales and profit.

SELECT 
    product AS product, 
    ROUND(SUM(sales), 2) AS total_sales, 
    ROUND(SUM(profit), 2) AS total_profit
FROM 
    sales
GROUP BY 
    product
ORDER BY 
    total_sales DESC;


	#5. Monthly Sales Trends and Service Types
			-- Showcases the monthly performance of different sales of services.

SELECT 
    YEAR(O.order_date) AS year, 
    QUARTER(O.order_date) AS quarter,
    S.product AS product, 
    ROUND(SUM(S.sales), 2) AS total_sales
FROM 
    order_info O
INNER JOIN 
    sales S ON O.order_id = S.order_id
GROUP BY 
    year, quarter, product
ORDER BY 
    year, quarter, total_sales DESC;
    
    
    #6. CUSTOMER LIFESPAN
        -- Calculates the lifespan of each customer by measuring the number of days between their first and last order, and then groups the results by customer ID.
        
SELECT  DATEDIFF(MAX(order_date),MIN(order_date)) as customer_lifespan ,
		employee_id
FROM order_info
GROUP BY employee_id;


	#7. CUSTOMER AVERAGE ORDER VALUE
		-- Calculates the average order value for each customer by dividing their total sales by the number of orders they've made, and then groups the results by customer ID.
        
SELECT 	SUM(S.sales)/count(S.order_id) AS average_order_value_of_customers,
		O.employee_id
FROM sales S INNER JOIN order_info O ON S.order_id=O.order_id
GROUP BY O.employee_id;


	#8. Total Annual Customer Churn Analysis
		
        /* Calculates the total number of customers, the number of customers who have not made a purchase in over a year (churned customers), 
			and the churn rate (the percentage of churned customers out of the total),
            by comparing each customer's most recent order date with their previous order date.	*/

SELECT 
    COUNT(employee_id) AS total_customers,
    SUM(CASE WHEN DATEDIFF(last_order_date, prev_order_date) >= 365 THEN 1 ELSE 0 END) AS churned_customers,
    (SUM(CASE WHEN DATEDIFF(last_order_date, prev_order_date) >= 365 THEN 1 ELSE 0 END) / COUNT(employee_id)) * 100 AS churn_rate
FROM (
    SELECT 
        E.employee_id, 
        MAX(O.order_date) AS last_order_date,
        MAX(O2.order_date) AS prev_order_date
    FROM 
        employees E
    INNER JOIN 
        order_info O ON E.employee_id = O.employee_id
    LEFT JOIN
        order_info O2 ON E.employee_id = O2.employee_id AND O2.order_date < O.order_date
    GROUP BY 
        E.employee_id
) AS orders;


	#9.	Annual Churn Rate of Companies 
			
            /*	Calculates the number of employees for each company, the number of employees who haven't made a purchase in over a year (churned employees),
				and the churn rate (the percentage of churned employees out of the total) for each company. 
				It uses two common table expressions (CTEs): the first CTE gathers data about each employee's purchase history and identifies whether they have churned, 
                and the second CTE summarizes this information by company.	*/
                
WITH CTE AS(
SELECT 
        E.employee_id,
        C.company,
        MAX(O.order_date) AS last_order_date,
        MAX(O2.order_date) AS prev_order_date,
        CASE
			WHEN DATEDIFF(MAX(O.order_date),MAX(O2.order_date))>= 365 THEN 1 ELSE 0 END AS churned_customer
    FROM 
        employees E
    INNER JOIN 
        order_info O ON E.employee_id = O.employee_id
    LEFT JOIN
        order_info O2 ON E.employee_id = O2.employee_id AND O2.order_date < O.order_date
	INNER JOIN 
		companies C ON E.company_id = C.company_id
    GROUP BY 
        E.employee_id,C.company
        ),
	CTE1 AS(
	SELECT 
		company,
        count(company) AS Number_of_employees,
        SUM(churned_customer)AS Employees_that_didnt_repurchase,
        SUM(churned_customer)/count(company) AS company_churn_rate
    FROM CTE
    GROUP BY company)
    SELECT *
    FROM CTE1;
    

	#10. Calculating Revenue Churn Rate
		
        /*	Calculates monthly retained revenue, churned revenue, and the revenue churn rate (the percentage of churned revenue out of the total revenue) for each month. 
			It first gathers sales data along with previous order dates for each employee, then categorizes the revenue as retained or churned based on whether the employee repurchased within a year. 
			Finally, it aggregates and rounds the revenue data by year and month, computing the churn rate for each month.	*/
            
WITH order_sales AS (
    SELECT 
        O.employee_id,
        O.order_id,
        O.order_date,
        S.sales,
        LAG(O.order_date) OVER (PARTITION BY O.employee_id ORDER BY O.order_date) AS prev_order_date
    FROM 
        order_info O
    INNER JOIN 
        sales S ON O.order_id = S.order_id
),
order_summary AS (
    SELECT 
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        MONTHNAME(order_date) AS month_name,
        CASE 
            WHEN DATEDIFF(order_date, prev_order_date) <= 365 THEN sales 
            ELSE 0 
        END AS retained_revenue,
        CASE 
            WHEN DATEDIFF(order_date, prev_order_date) > 365 THEN sales 
            ELSE 0 
        END AS churned_revenue
    FROM 
        order_sales
)
SELECT 
    year,
    month,
    month_name,
    ROUND(SUM(retained_revenue), 2) AS retained_revenue,
    ROUND(SUM(churned_revenue), 2) AS churned_revenue,
    ROUND(ROUND(SUM(churned_revenue), 2) / ROUND(SUM(retained_revenue + churned_revenue), 2)* 100,2) AS revenue_churn_rate
FROM 
    order_summary
GROUP BY 
    year, month, month_name
ORDER BY 
    year, month;


	#11. Customer Lifetime Value (CLV)
		
        /*	Calculates the Customer Lifetime Value (CLV) for each customer by estimating how much revenue they generate over the time they are active. 
			It first determines how many months each customer has been active and then calculates their average monthly revenue. 
			Finally, it multiplies these values to estimate the total revenue each customer is expected to bring in during their relationship with the company, and then ranks the customers by their CLV from highest to lowest.*/

WITH active_months AS (
    SELECT 
        E.employee_id, 
        C.company,
        CASE 
            WHEN MIN(O.order_date) = MAX(O.order_date) THEN 1
            ELSE TIMESTAMPDIFF(MONTH, MIN(O.order_date), MAX(O.order_date)) + 1
        END AS months_active
    FROM 
        employees E
    INNER JOIN 
        order_info O ON E.employee_id = O.employee_id 
    INNER JOIN 
        companies C ON E.company_id = C.company_id
    GROUP BY 
        E.employee_id, C.company
),
avg_monthly_revenue AS (
    SELECT 
        E.employee_id AS customer_id,
        E.employee_name AS customer_name,
        C.company, 
        ROUND(AVG(S.sales), 2) AS avg_monthly_revenue
    FROM 
        employees E
    INNER JOIN 
        order_info O ON E.employee_id = O.employee_id 
    INNER JOIN 
        sales S ON O.order_id = S.order_id 
    INNER JOIN 
        companies C ON E.company_id = C.company_id
    GROUP BY 
        E.employee_id, E.employee_name, C.company
)
SELECT 
    am.employee_id AS customer_id,
    ar.customer_name,
    am.company,
    ROUND(SUM(am.months_active * ar.avg_monthly_revenue), 2) AS customer_lifetime_value
FROM 
    active_months am
INNER JOIN 
    avg_monthly_revenue ar ON am.employee_id = ar.customer_id
GROUP BY 
    am.employee_id, ar.customer_name, am.company
ORDER BY 
    customer_lifetime_value DESC;
    
