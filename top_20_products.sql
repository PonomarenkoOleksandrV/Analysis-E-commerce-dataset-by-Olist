SELECT order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at,
order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date
FROM orders;
/*Топ-20 товарів за доходом
Фільтрує тільки валідні товари з категоріями
Обчислює Revenue і кількість проданих одиниць
Показує топ-20 по виручці*/

with stock_date as (SELECT 
   orders.order_id,
   orders.customer_id,
   orders.order_purchase_timestamp,
   order_items.price,
   order_items.product_id,
   products.product_category_name,
   product_category_name_translation.product_category_name_english
FROM orders
left JOIN order_items  ON orders.order_id = order_items.order_id
left join products on order_items.product_id=products.product_id
left join product_category_name_translation on products.product_category_name=product_category_name_translation.product_category_name)
select
   product_id,
   product_category_name,
   product_category_name_english,
   SUM(price) as total_revenue,
   count(product_id) as total_product_sell
   from stock_date
   where product_id is not null and product_category_name  is not null
   group by product_id,product_category_name, product_category_name_english
   ORDER BY total_revenue DESC
   Limit  20 


