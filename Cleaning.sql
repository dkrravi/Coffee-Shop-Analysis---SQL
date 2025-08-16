CREATE DATABASE coffee_db;
USE coffee_db;


SELECT * FROM sales;
DESCRIBE sales;
SET SQL_SAFE_UPDATES=0;


ALTER TABLE sales
ADD COLUMN transaction_date_new DATE,
ADD COLUMN transaction_time_new TIME;

UPDATE sales
SET 
    transaction_date_new = STR_TO_DATE(transaction_date, '%d-%m-%Y'),
    transaction_time_new = STR_TO_DATE(transaction_time, '%H:%i:%s');
    
ALTER TABLE sales
DROP COLUMN transaction_date,
DROP COLUMN transaction_time;

ALTER TABLE sales
CHANGE COLUMN transaction_date_new transaction_date DATE AFTER transaction_id,
CHANGE COLUMN transaction_time_new transaction_time TIME AFTER transaction_date;

ALTER TABLE sales
DROP COLUMN product_detail;

ALTER TABLE sales
ADD COLUMN total_price DECIMAL(10,2) AFTER unit_price;

UPDATE sales
SET total_price = transaction_qty * unit_price;


