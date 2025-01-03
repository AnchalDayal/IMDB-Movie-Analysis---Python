-- 1. Sales Performance Analysis
-- Query 1: Total Sales Revenue per Category, Sub-Category, and Region
SELECT
    p.product_category,
    c.customer_state AS region,
    SUM(pay.payment_value) AS total_sales_revenue
FROM
    ecommerce.order_items oi
JOIN ecommerce.products p ON oi.product_id = p.product_id
JOIN ecommerce.orders o ON oi.order_id = o.order_id
JOIN ecommerce.customers c ON o.customer_id = c.customer_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    p.product_category,
    c.customer_state;

-- Total Sales Revenue Check
SELECT SUM(payment_value) AS total_sales FROM ecommerce.payments;

-- Query 2: Top 5 Best-Selling Products by Both Sales Revenue and Quantity Sold
-- Top 5 Products by Total Sales Revenue
SELECT
    p.product_id,
    p.product_category,
    SUM(pay.payment_value) AS total_sales_revenue
FROM
    ecommerce.order_items oi
JOIN ecommerce.products p ON oi.product_id = p.product_id
JOIN ecommerce.orders o ON oi.order_id = o.order_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    p.product_id,
    p.product_category
ORDER BY
    total_sales_revenue DESC
LIMIT 5;

-- Top 5 Products by Quantity Sold
SELECT
    p.product_id,
    p.product_category,
    COUNT(oi.order_item_id) AS total_quantity_sold
FROM
    ecommerce.order_items oi
JOIN ecommerce.products p ON oi.product_id = p.product_id
JOIN ecommerce.orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    p.product_id,
    p.product_category
ORDER BY
    total_quantity_sold DESC
LIMIT 5;

-- 2. Customer Insights
-- Query 1: Most Loyal Customers by Purchase Frequency and Total Spend
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS purchase_frequency,
    SUM(pay.payment_value) AS total_spend
FROM
    ecommerce.customers c
JOIN ecommerce.orders o ON c.customer_id = o.customer_id
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    c.customer_unique_id
ORDER BY
    purchase_frequency DESC,
    total_spend DESC
LIMIT 10;

-- Query 2: Customers with the Highest Average Order Value (AOV)
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders,
    SUM(pay.payment_value) AS total_spend,
    SUM(pay.payment_value) / COUNT(o.order_id) AS average_order_value
FROM
    ecommerce.customers c
JOIN ecommerce.orders o ON c.customer_id = o.customer_id
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    c.customer_unique_id
HAVING
    total_orders > 1
ORDER BY
    average_order_value DESC
LIMIT 10;

-- 3. Operational Efficiency
-- Query 1: Average Delivery Time by Region
SELECT
    c.customer_state AS region,
    AVG(DATEDIFF(COALESCE(o.order_delivered_customer_date, CURRENT_DATE), o.order_purchase_timestamp)) AS avg_delivery_time
FROM
    ecommerce.orders o
JOIN ecommerce.customers c ON o.customer_id = c.customer_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    c.customer_state
ORDER BY
    avg_delivery_time;

-- Query 2: Regions with the Highest Return Rates
SELECT
    c.customer_state AS region,
    COUNT(CASE WHEN o.order_status = 'canceled' THEN 1 END) / COUNT(o.order_id) * 100 AS return_rate
FROM
    ecommerce.orders o
JOIN ecommerce.customers c ON o.customer_id = c.customer_id
WHERE
    o.order_status IN ('delivered', 'canceled')
GROUP BY
    c.customer_state
ORDER BY
    return_rate DESC
LIMIT 5;

-- 4. Date and Time Analytics
-- Query 1: Monthly Sales Trend for the Last Two Years
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    SUM(pay.payment_value) AS total_sales
FROM
    ecommerce.orders o
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)
ORDER BY
    year DESC, month DESC;

-- Query 2: Seasonality of Sales to Identify Peak Months
SELECT
    MONTH(o.order_purchase_timestamp) AS month,
    SUM(pay.payment_value) AS total_sales
FROM
    ecommerce.orders o
JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    MONTH(o.order_purchase_timestamp)
ORDER BY
    total_sales DESC;

-- 5. Advanced SQL Queries
-- Query 1: Rank Products Based on Sales Within Each Category
SELECT
    p.product_category,
    p.product_id,
    SUM(pay.payment_value) AS total_sales,
    RANK() OVER (PARTITION BY p.product_category ORDER BY SUM(pay.payment_value) DESC) AS rank_within_category
FROM
    ecommerce.order_items oi
JOIN ecommerce.products p ON oi.product_id = p.product_id
JOIN ecommerce.orders o ON oi.order_id = o.order_id
JOIN ecommerce.payments pay ON o.order_id = pay.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    p.product_category, p.product_id
ORDER BY
    p.product_category, rank_within_category;

-- Query 2: Month-to-Date (MTD) and Year-to-Date (YTD) Sales Metrics
WITH daily_sales AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS sale_date,
        SUM(pay.payment_value) AS daily_sales
    FROM
        ecommerce.orders o
    JOIN ecommerce.order_items oi ON o.order_id = oi.order_id
    JOIN ecommerce.payments pay ON o.order_id = pay.order_id
    WHERE
        o.order_status = 'delivered'
    GROUP BY
        DATE(o.order_purchase_timestamp)
)
SELECT
    sale_date,
    daily_sales,
    SUM(daily_sales) OVER (
        PARTITION BY YEAR(sale_date), MONTH(sale_date)
        ORDER BY sale_date
    ) AS mtd_sales,
    SUM(daily_sales) OVER (
        PARTITION BY YEAR(sale_date)
        ORDER BY sale_date
    ) AS ytd_sales
FROM
    daily_sales
ORDER BY
    sale_date;
