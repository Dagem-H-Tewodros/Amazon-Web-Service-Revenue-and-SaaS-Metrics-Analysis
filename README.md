# Amazon Web Service Revenue and SaaS Metrics Analysis

## Overview
This project involves transforming AWS sales data from Kaggle into actionable insights using MySQL for ETL (Extract, Transform, Load) processes and Tableau for data visualization. The goal of the project is to extract key metrics for SaaS (Software as a Service) companies, including:
- **Revenue trends and growth analysis**
- **Churn rate**
- **Average Revenue Per Customer (ARPC)**

## Project Objectives
The main objectives of this project include:
1. **Data extraction**: Load AWS sales data from a CSV file into MySQL.
2. **Data normalization and cleaning**: Ensure data is well-structured and normalized to avoid redundancy and inconsistency.
3. **Exploratory analysis**: Identify and calculate key SaaS metrics such as churn rate, revenue growth, and ARPC.
4. **Data visualization**: Use Tableau to create dashboards and visualizations for insightful presentations of the analysis results.

## Files in the Repository
- `AWS_dataset.csv`: The original sales dataset from AWS in CSV format.
- `Data Normalization and Cleaning.sql`: SQL script for normalizing and cleaning the data.
- `Functions.sql`: Contains SQL functions used in the analysis process.
- `Indexes.sql`: SQL script for creating database indexes to improve performance.
- `Stored Procedures.sql`: SQL stored procedures used for analysis.
- `Views.sql`: SQL views to help with data extraction and transformation.
- `README.md`: (This file) Contains a summary of the project and instructions.

## Key Steps

### 1. Data Extraction
- The AWS sales data is extracted from a CSV file and imported into MySQL using the following script:
  - `AWS_dataset.csv` loaded into MySQL for further analysis.

### 2. Data Normalization & Cleaning
- The script `Data Normalization and Cleaning.sql` contains SQL statements for:
  - Removing duplicates and handling missing values.
  - Ensuring that the database is normalized (i.e., organized into tables with minimum redundancy).

### 3. Exploratory Analysis & Metrics Calculation
- The script `Revenue Trends and SaaS Metrics Exploratory.sql` contains queries that calculate essential SaaS metrics like churn rate and ARPC.
- Other trends such as revenue growth can also be tracked over time.

### 4. Data Visualization
- The cleaned and structured data is imported into Tableau for building insightful dashboards. These dashboards visually represent the trends and metrics uncovered in the analysis.

## Tableau Dashboard
You can view the Tableau dashboard with all the visualizations and insights from the analysis by following this link:

[Click here to view the Tableau dashboard](https://public.tableau.com/views/AmazonWebServicesSaasOverview/AWSSalesSummary?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## How to Run
1. Clone the repository:
    ```bash
    git clone https://github.com/Dagem-H-Tewodros/Amazon-Web-Service-Revenue-and-SaaS-Metrics-Analysis.git
    ```

2. Import the AWS dataset into MySQL using your preferred method or command-line tools.

3. Execute the SQL scripts in the following order:
   - `Data Normalization and Cleaning.sql`
   - `Functions.sql`
   - `Indexes.sql`
   - `Stored Procedures.sql`
   - `Views.sql`

4. Once the data is processed, you can either:
   - Run exploratory analysis queries directly in MySQL using `Revenue Trends and SaaS Metrics Exploratory.sql`.

## Dependencies
- **MySQL**: Database management system for processing the data.
- **Tableau**: For building data visualizations and dashboards.
- **Kaggle**: Data source for the AWS sales data used in this project.

## Future Enhancements
- Automating the ETL process using a pipeline tool.
- Adding machine learning models to predict churn rate and customer lifetime value (CLV).

## Contact
For any questions or collaboration opportunities, feel free to contact the repository maintainer via [GitHub](https://github.com/Dagem-H-Tewodros).
