with 
    stg_detail as (
        select *
        from {{ ref('stg_purchase_order_detail') }}
    )

    , stg_order as (
        select *
        from {{ ref('stg_purchase_order_header') }}
    )

    , stg_shipmethod as (
        select *
        from {{ ref('stg_purchase_ship_method') }}
    )

    , stg_product as (
        select *
        from {{ ref('stg_product') }}
    ) 

    , purchasing_mapping as (
        select 
            -- Primary key 
            {{ dbt_utils.surrogate_key(['stg_detail.purchaseorderdetail_pk']) }} as purchaseorderdetail_pk
            -- Foreign key
            , {{ dbt_utils.surrogate_key(['stg_order.purchaseorder_pk']) }} as purchaseorder_fk
            , {{ dbt_utils.surrogate_key(['stg_product.product_pk']) }} as product_fk
            , {{ dbt_utils.surrogate_key(['stg_shipmethod.shipmethod_pk']) }} as shipmethod_fk
            -- Others columns
            , stg_detail.order_qty
            , stg_detail.unit_price
            , stg_detail.received_qty
            , stg_detail.rejected_qty
            , stg_order.pur_status
            , stg_order.orderdate
            , stg_order.shipdate
            , stg_order.subtotal
            , stg_order.taxamt
            , stg_order.freight
            , stg_order.totaldue
        from stg_detail
        left join stg_order 
        on stg_detail.purchaseorder_fk = stg_order.purchaseorder_pk
        left join stg_product
        on stg_detail.product_fk = stg_product.product_pk
        left join stg_shipmethod
        on stg_order.shipmethod_fk = stg_shipmethod.shipmethod_pk
        where stg_order.pur_status = 'complete'
    )

select *    
from purchasing_mapping


