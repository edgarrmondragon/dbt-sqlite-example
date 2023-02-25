with

customer_cohorts as (

    select
        customer_id
        , cast(date({{ parse_ddmmyyyy_date("date") }}, 'start of month') as text) as cohort_month
    from {{ source('retail', 'scanner_data') }}
    group by 1

)

, orders as (

    select
        transaction_id
        , cast(min({{ parse_ddmmyyyy_date("date") }}) as text) as order_date
        , cast(min(customer_id) as text) as customer_id
        , cast(count(sku) as int) as items
        , cast(count(distinct sku) as int) as unique_items
        , cast(sum(sales_amount) as real) as amount
    from {{ source('retail', 'scanner_data') }}
    group by 1

)

select
    orders.*
    , customer_cohorts.cohort_month
    , cast(date(orders.order_date, 'start of month') as text) as order_month
    , cast(12 * (
        strftime(
            '%Y', orders.order_date
        ) - strftime('%Y', customer_cohorts.cohort_month)
        )
        + (
            strftime(
                '%m', orders.order_date
            ) - strftime('%m', customer_cohorts.cohort_month)
        ) as int) as cohort_index
from orders
inner join customer_cohorts on orders.customer_id = customer_cohorts.customer_id
