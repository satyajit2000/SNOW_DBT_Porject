{{ config(
materialized='ephemeral'
)}}

WITH tb1 as(
    select id,
    first_name,
    last_name
    from {{source('datafeed_shared_schema','raw_customer')}})
