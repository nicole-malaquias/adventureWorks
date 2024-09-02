with 
    order_reason as (
        select *
        from {{ ref('int_order_reason') }}
    )

select *
from order_reason