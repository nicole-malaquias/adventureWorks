with 
    order_reason as (
        select *
        from {{ ref('stg_sales_order_header_reason') }}
    )

    , reason as (
        select *
        from {{ ref('stg_sales_reason') }}
    )

    , dim_order_reason as (
        select 
            -- Primary Key
            {{ dbt_utils.surrogate_key(['order_reason_pk'])}} as order_head_pk
            -- Other Columns
            , reason.reason_name
            , reason.reasontype
        from order_reason
        left join reason 
        on order_reason.reason_fk = reason.reason_pk
    )

select *
from dim_order_reason
