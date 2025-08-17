SELECT order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date
FROM orders;

SELECT 
o.order_id,
o.customer_id,
o.order_status,
o.order_purchase_timestamp,
o.order_approved_at,
o.order_delivered_customer_date,
c.customer_city,
c.customer_state,
c.customer_zip_code_prefix,
oi.product_id,
oi.seller_id,
oi.price,
oi.freight_value,
g.geolocation_state,
g.geolocation_city,
g.geolocation_lng,
g.geolocation_lat,
p.product_category_name,
e.product_category_name_english
from orders o
left join customers c on o.customer_id=c.customer_id
left join order_items oi on o.order_id=oi.order_id
left join geolocation g on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
left join products p on oi.product_id=p.product_id
left join product_category_name_translation e on p.product_category_name=e.product_category_name


