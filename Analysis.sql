USE coffee_db;

SELECT * FROM sales;
-- Total Transactions
SELECT COUNT(*) AS total_transactions
FROM sales;

-- Total Distinct Transaction Dates
SELECT COUNT(DISTINCT transaction_date) AS `Number of Transaction Dates`
FROM sales;

-- Distinct Store Locations
SELECT DISTINCT store_location AS `Distinct Store Locations`
FROM sales;

-- Total Quantity Sold
SELECT SUM(transaction_qty) AS `Total Quantity Sold`
FROM sales;

-- Distinct Product Categories
SELECT DISTINCT product_category AS `Distinct Product Categories`
FROM sales;

-- Distinct Product Types
SELECT DISTINCT product_type AS `Distinct Product Types`
FROM sales;

-- monthly-wise number of orders
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS `Month`,
    COUNT(*) AS `Number of Orders`
FROM sales
GROUP BY `Month`
ORDER BY `Month`;

-- How many orders were placed for Coffee vs. Tea

SELECT 
    product_category AS `Category`,
    COUNT(*) AS `Number of Orders`
FROM sales
WHERE product_category IN ('Coffee', 'Tea')
GROUP BY product_category;

-- monthly-wise total revenue
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS `Month`,
    ROUND(SUM(total_price), 2) AS `Total Revenue`
FROM sales
GROUP BY `Month`
ORDER BY `Month`;

-- most expensive product
SELECT product_category, product_type, unit_price AS `Price`
FROM sales
ORDER BY unit_price DESC
LIMIT 1;

-- least expensive product
SELECT product_category, product_type, unit_price AS `Price`
FROM sales
ORDER BY unit_price ASC
LIMIT 1;

-- total revenue and order per store location
SELECT 
    store_location AS `Store Location`,
    COUNT(*) AS `Number of Orders`,
    ROUND(SUM(total_price), 2) AS `Total Revenue`
FROM sales
GROUP BY store_location
ORDER BY `Total Revenue` DESC;


-- product with the highest quantity sold,
SELECT 
    product_category, 
    product_type,
    SUM(transaction_qty) AS `Total Quantity Sold`
FROM sales
GROUP BY product_category, product_type
ORDER BY `Total Quantity Sold` DESC
LIMIT 1;


-- product with the lowest quantity sold
SELECT 
    product_category, 
    product_type,
    SUM(transaction_qty) AS `Total Quantity Sold`
FROM sales
GROUP BY product_category, product_type
ORDER BY `Total Quantity Sold` ASC
LIMIT 1;

-- the product with the highest sales in Lower Manhattan
SELECT product_type
FROM sales
WHERE store_location = 'Lower Manhattan'
GROUP BY product_type
ORDER BY SUM(transaction_qty * unit_price) DESC
LIMIT 1;

-- Tea orders “Hell's Kitchen” handled in February 2023
SELECT 
    COUNT(*) AS `Number of Tea Orders`
FROM sales
WHERE store_location = "Hell's Kitchen"
  AND product_category = 'Tea'
  AND MONTH(transaction_date) = 2
  AND YEAR(transaction_date) = 2023;
  
  
