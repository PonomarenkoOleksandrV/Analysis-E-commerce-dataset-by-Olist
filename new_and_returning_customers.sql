
WITH first_orders AS (
    -- Знаходимо перше замовлення кожного клієнта
    SELECT
        customer_id,
        MIN(order_purchase_timestamp) AS first_order_date
    FROM orders
    GROUP BY customer_id
),
orders_with_flag AS (
    -- Додаємо ознаку: чи це перше замовлення, чи повторне
    SELECT
        o.customer_id,
        o.order_purchase_timestamp,
        CASE
            WHEN o.order_purchase_timestamp = f.first_order_date
                 THEN 'new'
            ELSE 'returning'
        END AS customer_type
    FROM orders o
    JOIN first_orders f ON o.customer_id = f.customer_id
)
SELECT
    SUBSTR(order_purchase_timestamp, 1, 7) AS month,
    COUNT(DISTINCT CASE WHEN customer_type = 'new' THEN customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN customer_type = 'returning' THEN customer_id END) AS returning_customers
FROM orders_with_flag
GROUP BY SUBSTR(order_purchase_timestamp, 1, 7)
ORDER BY month

