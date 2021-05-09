with

customer_cohorts as (

  select
    customer_id
    , date(min(date), 'start of month') as cohort_month
  from {{ source('etl', 'scanner_data') }}
  group by 1

)

, orders as (

  select
    transaction_id
    , min(date) as order_date
    , min(customer_id) as customer_id
    , count(sku) as items
    , count(distinct sku) as unique_items
    , sum(sales_amount) as amount
  from {{ source('etl', 'scanner_data') }}
  group by 1

)

select
  orders.*
  , customer_cohorts.cohort_month
  , date(orders.order_date, 'start of month') as order_month
  , 12 * (
    strftime('%Y', orders.order_date) - strftime('%Y', customer_cohorts.cohort_month)
  )
  + (
    strftime('%m', orders.order_date) - strftime('%m', customer_cohorts.cohort_month)
  ) as cohort_index
from orders
join customer_cohorts on orders.customer_id = customer_cohorts.customer_id
