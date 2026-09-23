
{{ config(materialized='ephemeral') }}

WITH tb1 as(
    select id,
    order_date,
    user_id
    status
    from {{source('datafeed_shared_schema','raw_orders')}})
