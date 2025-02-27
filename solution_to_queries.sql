-- Zepto Data Analysis using SQL
-- Solutions of 15 business problems


CREATE DATABASE zepto_db;
USE zepto_db;

CREATE TABLE zepto_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_category VARCHAR(100) NOT NULL,
    order_time DATETIME NOT NULL,
    expected_delivery_time DATETIME NOT NULL,
    actual_delivery_time DATETIME,
    delivery_status VARCHAR(50) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    order_value DECIMAL(10,2) NOT NULL,
    delivery_person_id INT,
    region VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);


-- 1)Retrieve all orders

select * from zepto_orders;

-- 2)Finding late deliveries

create view late_deliveries as
SELECT * FROM zepto_orders
WHERE actual_delivery_time > expected_delivery_time;

select * from late_deliveries;

-- 3)Count orders by category

create view orders_by_category as
SELECT product_category, COUNT(*) AS total_orders
FROM zepto_orders
GROUP BY product_category;

select * from orders_by_category;

-- 4)Find revenue by region

CREATE VIEW revenue_by_region AS
SELECT region, SUM(order_value) AS total_revenue
FROM zepto_orders
GROUP BY region;

select * from revenue_by_region;

-- 5)Retrieve all successful deliveries

CREATE VIEW successful_deliveries AS
SELECT order_id, customer_id, actual_delivery_time, delivery_status
FROM zepto_orders
WHERE delivery_status = 'Delivered';

select * from successful_deliveries;

-- 6)Find the average delivery time for each product category

CREATE VIEW avg_del_time_pc AS
SELECT product_category, AVG(TIMESTAMPDIFF(MINUTE, order_time, actual_delivery_time)) AS avg_delivery_time 
FROM zepto_orders 
GROUP BY product_category;

select * from avg_del_time_pc;

-- 7)Get the total number of canceled orders by customers

CREATE VIEW total_canceled_orders  AS
SELECT COUNT(order_id) AS total_canceled_orders 
FROM zepto_orders 
WHERE delivery_status = 'Cancelled';

select * from total_canceled_orders; 

-- 8)List the top 5 products with the highest number of orders

CREATE VIEW top_5_products  AS
SELECT product_name, COUNT(order_id) AS total_orders 
FROM zepto_orders 
GROUP BY product_name 
ORDER BY total_orders DESC 
LIMIT 5;

select * from top_5_products; 

-- 9)Calculate the total revenue from successful orders

CREATE VIEW total_revenue_from_successful_orders AS
SELECT SUM(order_value) AS total_revenue 
FROM zepto_orders 
WHERE delivery_status = 'Delivered';

select * from total_revenue_from_successful_orders; 

-- 10)Identify locations with the highest delivery delays

CREATE VIEW location_highest_delivery_delays AS
SELECT region, city, COUNT(order_id) AS delayed_orders 
FROM zepto_orders 
WHERE TIMESTAMPDIFF(Minute, expected_delivery_time, actual_delivery_time) > 15 
GROUP BY region, city 
ORDER BY delayed_orders DESC;

select * from location_highest_delivery_delays; 

 -- 11)Find the top 5 delivery personnel with the fastest average delivery times

CREATE VIEW top_5_delivery_personnel AS
SELECT delivery_person_id, AVG(TIMESTAMPDIFF(MINUTE, order_time, actual_delivery_time)) AS avg_delivery_time 
FROM zepto_orders 
WHERE delivery_status = 'Delivered' 
GROUP BY delivery_person_id 
ORDER BY avg_delivery_time ASC 
LIMIT 5;

select * from top_5_delivery_personnel; 

-- 12)Find the city with the highest number of orders

CREATE VIEW city_with_highest_orders AS
SELECT city, COUNT(order_id) AS total_orders 
FROM zepto_orders 
GROUP BY city 
ORDER BY total_orders DESC 
LIMIT 1;

select * from city_with_highest_orders; 

-- 13)Get the most frequently used payment method

CREATE VIEW frequent_payment_method AS
SELECT payment_method, COUNT(order_id) AS usage_count 
FROM zepto_orders 
GROUP BY payment_method 
ORDER BY usage_count DESC 
LIMIT 1;

select * from frequent_payment_method; 

-- 14) Identify which payment method has the highest failure rate

CREATE VIEW payment_method_failure_rate AS
SELECT payment_method, COUNT(order_id) AS failed_orders
FROM zepto_orders
WHERE delivery_status = 'Cancelled'
GROUP BY payment_method
ORDER BY failed_orders DESC
LIMIT 1;

select * from payment_method_failure_rate; 

-- 15)Determine how many orders were paid via Cash on Delivery (COD)

CREATE VIEW paid_via_COD AS
SELECT COUNT(order_id) AS cod_orders
FROM zepto_orders
WHERE payment_method = 'Cash on Delivery';

select * from paid_via_COD; 
