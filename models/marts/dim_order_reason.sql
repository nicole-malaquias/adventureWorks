with 
    order_reason as (
        select *
        from {{ ref('stg_sales_order_header_reason') }}
    )

    , reason as (
        select *
        from {{ ref('stg_sales_reason') }}
    )

    , combined_data as (
        select 
            {{ dbt_utils.surrogate_key(['order_reason.order_head_fk']) }} as reason_header_pk 
            , order_reason.order_head_fk as sales_header_fk
            , reason.reason_name
            , reason.reasontype
        from order_reason
        left join reason 
        on order_reason.reason_fk = reason.reason_pk
    )

    , dim_order_reason as (
        select 
            sales_header_fk 
            , string_agg(distinct reason_name, ', ') as reason_names
            , string_agg(distinct reasontype, ', ') as reason_types 
        from 
            combined_data
        group by 
            sales_header_fk 
    )

    , representative_reason as (
        select 
            sales_header_fk
            , SPLIT(reason_names, ', ')[ORDINAL(1)] as representative_reason_name
            , SPLIT(reason_types, ', ')[ORDINAL(1)] as representative_reason_type
        from dim_order_reason
    )

select *
from representative_reason