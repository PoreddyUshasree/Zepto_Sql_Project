# Zepto Orders Data Analysis using SQL

![](https://github.com/PoreddyUshasree/Zepto_Sql_Project/blob/main/Zepto_logo.png)

## Overview
This project involves analyzing the Zepto orders dataset using SQL to gain valuable insights into order trends, delivery performance, revenue generation, and customer behavior. The following README provides an in-depth explanation of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Retrieve and analyze all orders.
- Identify late deliveries and their impact.
- Categorize orders based on product categories.
- Compute revenue generation by region.
- Identify successful deliveries and average delivery times.
- Find the most frequently ordered products and payment methods.
- Assess order cancellation trends and payment method failure rates.

## Database Schema

```sql
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
```

## Business Problems and Solutions

### 1. Retrieve all orders
```sql
SELECT * FROM zepto_orders;
```

### 2. Identify Late Deliveries
```sql
CREATE VIEW late_deliveries AS
SELECT * FROM zepto_orders
WHERE actual_delivery_time > expected_delivery_time;
```

### 3. Count Orders by Category
```sql
CREATE VIEW orders_by_category AS
SELECT product_category, COUNT(*) AS total_orders
FROM zepto_orders
GROUP BY product_category;
```

### 4. Calculate Revenue by Region
```sql
CREATE VIEW revenue_by_region AS
SELECT region, SUM(order_value) AS total_revenue
FROM zepto_orders
GROUP BY region;
```

### 5. Retrieve Successful Deliveries
```sql
CREATE VIEW successful_deliveries AS
SELECT order_id, customer_id, actual_delivery_time, delivery_status
FROM zepto_orders
WHERE delivery_status = 'Delivered';
```

### 6. Find Average Delivery Time by Product Category
```sql
CREATE VIEW avg_del_time_pc AS
SELECT product_category, AVG(TIMESTAMPDIFF(MINUTE, order_time, actual_delivery_time)) AS avg_delivery_time
FROM zepto_orders
WHERE actual_delivery_time IS NOT NULL
GROUP BY product_category;
```

### 7. Count Canceled Orders
```sql
CREATE VIEW total_canceled_orders AS
SELECT COUNT(order_id) AS total_canceled_orders
FROM zepto_orders
WHERE delivery_status = 'Cancelled';
```

### 8. List Top 5 Most Ordered Products
```sql
CREATE VIEW top_5_products AS
SELECT product_name, COUNT(order_id) AS total_orders
FROM zepto_orders
GROUP BY product_name
ORDER BY total_orders DESC
LIMIT 5;
```

### 9. Calculate Total Revenue from Successful Orders
```sql
CREATE VIEW total_revenue_from_successful_orders AS
SELECT SUM(order_value) AS total_revenue
FROM zepto_orders
WHERE delivery_status = 'Delivered';
```

### 10. Identify Locations with Highest Delivery Delays
```sql
CREATE VIEW location_highest_delivery_delays AS
SELECT region, city, COUNT(order_id) AS delayed_orders
FROM zepto_orders
WHERE TIMESTAMPDIFF(MINUTE, expected_delivery_time, actual_delivery_time) > 15
GROUP BY region, city
ORDER BY delayed_orders DESC;
```

### 11. Top 5 Fastest Delivery Personnel
```sql
CREATE VIEW top_5_delivery_personnel AS
SELECT delivery_person_id, AVG(TIMESTAMPDIFF(MINUTE, order_time, actual_delivery_time)) AS avg_delivery_time
FROM zepto_orders
WHERE delivery_status = 'Delivered'
GROUP BY delivery_person_id
ORDER BY avg_delivery_time ASC
LIMIT 5;
```

### 12. City with the Highest Number of Orders
```sql
CREATE VIEW city_with_highest_orders AS
SELECT city, COUNT(order_id) AS total_orders
FROM zepto_orders
GROUP BY city
ORDER BY total_orders DESC
LIMIT 1;
```

### 13. Most Frequently Used Payment Method
```sql
CREATE VIEW frequent_payment_method AS
SELECT payment_method, COUNT(order_id) AS usage_count
FROM zepto_orders
GROUP BY payment_method
ORDER BY usage_count DESC
LIMIT 1;
```

### 14. Payment Method with Highest Failure Rate
```sql
CREATE VIEW payment_method_failure_rate AS
SELECT payment_method, COUNT(order_id) AS failed_orders
FROM zepto_orders
WHERE delivery_status = 'Cancelled'
GROUP BY payment_method
ORDER BY failed_orders DESC
LIMIT 1;
```

### 15. Orders Paid via Cash on Delivery (COD)
```sql
CREATE VIEW paid_via_COD AS
SELECT COUNT(order_id) AS cod_orders
FROM zepto_orders
WHERE payment_method = 'Cash on Delivery';
```

## Findings and Conclusion

- **Late Deliveries:** Some regions experience significant delays, highlighting potential logistics inefficiencies.
- **Top-Ordered Products:** Understanding product demand helps in inventory management and marketing strategies.
- **Revenue Insights:** Identifying high-revenue regions can assist in strategic business expansion.
- **Delivery Personnel Performance:** Tracking average delivery times can improve service quality.
- **Payment Methods:** Analyzing frequently used and failed payment methods ensures smoother transactions.

## Author - Poreddy Ushasree

This project is part of my portfolio, showcasing SQL skills essential for data analysis roles. Feel free to connect with me for any queries, feedback, or collaboration opportunities!

### Stay Connected

- **LinkedIn:** [Connect with me](https://www.linkedin.com/in/poreddy-ushasree/)
- **GitHub:** [Check out my projects](https://github.com/PoreddyUshasree)
- **Email:** [Get in touch](mailto:poreddyushasree@gmail.com)

Thank you for your support, and I look forward to sharing more projects!

