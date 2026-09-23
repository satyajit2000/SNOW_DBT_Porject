{{config(materialized='table',
        transient='false')}}

with customers as (
  select
  id as customer_id,
  first_name,
  last_name
    from {{ref('emphr_cus')}}

),

orders as (
    select
    id as order_id,
    user_id as customer_id,
    order_date,
    status
from {{ref('emphr_orders')}}

),

customer_orders as (

 select
user_id,
min(order_date) as first_order_date,
max(order_date) as most_recent_order_date,
count(order_id) as number_of_orders
from orders
group by 1

),

final as (

select
customers.id,
customers.first_name,
customers.last_name,
customer_orders.first_order_date,
customer_orders.most_recent_order_date,
coalesce(customer_orders.number_of_orders, 0) as number_of_orders
from customers
left join customer_orders using (user_id)
)

select * from final
