SELECT order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, 
order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date


with date_from_tables as (SELECT 
    orders.order_id, 
    orders.customer_id, 
    orders.order_status, 
    orders.order_purchase_timestamp,
    strftime('%Y-%m-01', orders.order_purchase_timestamp) AS purchase_month,  -- початок місяця
    orders.order_approved_at, 
    orders.order_delivered_carrier_date, 
    orders.order_delivered_customer_date, 
    orders.order_estimated_delivery_date,
    order_items.price
FROM orders
LEFT JOIN order_items 
    ON orders.order_id = order_items.order_id),
    
    average_check as (select
    purchase_month,
    COUNT(order_id) as total_orders,
    Round(SUM(price),2) total_prise
    from date_from_tables
    group by purchase_month)
    
    select 
    purchase_month,
    total_orders,
    total_prise,
    round((total_prise/total_orders),2) as avg_check
    from average_check
    