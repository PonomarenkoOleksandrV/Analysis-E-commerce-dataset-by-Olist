SELECT 
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT c.customer_id) as customers_count,
    COUNT(DISTINCT o.order_id) as orders_count,
    round(SUM(oi.price),1) as total_sales,
    round(SUM(oi.price + oi.freight_value),1) as total_revenue
FROM customers c
left join orders o on c.customer_id = o.customer_id
left join order_items oi on o.order_id = oi.order_id
GROUP BY c.customer_city, c.customer_state