-- CTEs (Common Table Expressions)
with 
    detail_cte as (
        select *
        from {{ ref('stg_sales_order_detail') }}
    ),

    order_cte as (
        select *
        from {{ ref('stg_sales_order_header') }}
    ),

    product_cte as (
        select *
        from {{ ref('stg_product') }}
    ),

    customer_cte as (
        select *
        from {{ ref('stg_sales_customer') }}
    ),

    person_cte as (
        select *
        from {{ ref('stg_sales_person') }}
    ),

    territory_cte as (
        select *
        from {{ ref('stg_sales_territory') }}
    ),

    shipmethod_cte as (
        select *
        from {{ ref('stg_purchase_ship_method') }}
    ),

    addrees_cte as (
        select *
        from {{ ref('stg_person_address') }}
    ),

    reason_sales_cte as (
        select *
        from {{ ref('stg_sales_order_header_reason') }}
    ),

    -- Principal table that joins all CTEs
    complete_sales_order as (
        select 
            -- Primary Key
            {{ dbt_utils.surrogate_key(['detail_cte.salesorderdetail_pk']) }} as salesorderdetail_pk
            
            -- Foreign Keys 
            , {{ dbt_utils.surrogate_key(['order_cte.salesorder_pk']) }} as salesorder_fk
            , {{ dbt_utils.surrogate_key(['product_cte.product_pk']) }} as product_fk
            , {{ dbt_utils.surrogate_key(['person_cte.salesperson_pk']) }} as sales_person_fk
            , {{ dbt_utils.surrogate_key(['customer_cte.customer_pk']) }} as customer_fk
            , {{ dbt_utils.surrogate_key(['territory_cte.territory_pk']) }} as territory_fk
            , {{ dbt_utils.surrogate_key(['shipmethod_cte.shipmethod_pk']) }} as shipmethod_fk
            , {{ dbt_utils.surrogate_key(['addrees_cte.address_pk']) }} as address_fk

            -- Other Fields
            , detail_cte.carriertrackingnumber
            , order_cte.orderdate
            , order_cte.duedate
            , order_cte.shipdate
            , order_cte.status_description
            , order_cte.onlineorderflag
            , order_cte.subtotal
            , order_cte.taxamt
            , order_cte.totaldue
            , detail_cte.orderqty
            , detail_cte.unitprice
            , detail_cte.unitpricediscount
            , detail_cte.modifieddate

        from detail_cte 
        left join order_cte 
        on detail_cte.salesorder_fk = order_cte.salesorder_pk
        left join product_cte 
        on detail_cte.product_fk = product_cte.product_pk
        left join customer_cte 
        on order_cte.customer_fk = customer_cte.customer_pk
        left join person_cte 
        on order_cte.salesperson_fk = person_cte.salesperson_pk
        left join territory_cte 
        on order_cte.territory_fk = territory_cte.territory_pk
        left join shipmethod_cte 
        on order_cte.shipmethod_fk = shipmethod_cte.shipmethod_pk
        left join addrees_cte 
        on order_cte.billtoaddress_fk = addrees_cte.address_pk
    )

select *
from complete_sales_order