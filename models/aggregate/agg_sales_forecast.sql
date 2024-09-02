with 
    fct_cte as (
        select *
        from {{ ref('fct_order_detail') }}
        where status_description = 'Shipped'
    )
    , address_cte as (
        select *
        from {{ ref('dim_person_address') }}
    )
    , customer_cte as (
        select *
        from {{ ref('dim_sales_customer') }}
    )
    , product_cte as (
        select *
        from {{ ref('dim_product') }}
    )
    , month_week_cte as (
        select 
            fct_cte.*
            , extract(year from shipdate) as `year`
            , extract(month from shipdate) as `month`
        from fct_cte
    )
    , other_information as (
        select
            month_week_cte.*
            , customer_cte.store_name
            , address_cte.province_name
            , address_cte.country_name
            , product_cte.name as product_name
            , product_cte.category_name
            , product_cte.finishedgoodsflag
            , product_cte.standardcost
            , product_cte.productnumber
        from month_week_cte
        left join customer_cte 
            on month_week_cte.customer_fk = customer_cte.customer_pk
        left join address_cte
            on month_week_cte.address_fk = address_cte.address_pk
        left join product_cte
            on month_week_cte.product_fk = product_cte.product_pk
    )
    , aggregated_demand as (
        select 
            country_name
            , province_name
            , store_name
            , product_name
            , finishedgoodsflag
            , standardcost
            , productnumber
            , year
            , month
            , sum(orderqty) as total_qty 
        from other_information
        group by 
            country_name
            , province_name
            , store_name
            , product_name
            , finishedgoodsflag
            , standardcost
            , productnumber
            , year
            , month
    )
select 
    country_name
    , province_name
    , store_name
    , product_name
    , finishedgoodsflag
    , standardcost
    , productnumber
    , total_qty
    , year
    , month
from aggregated_demand