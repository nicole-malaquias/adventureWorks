with 
    product as (
        select *
        from {{ ref('int_product') }}
    )

    , product_dimension as (
        select
            {{ dbt_utils.surrogate_key(['product_pk']) }} as product_pk
            , name
            , productnumber
            , color
            , safetystocklevel
            , reorderpoint
            , standardcost
            , daystomanufacture
            , productline
            , class
            , style
            , sellstartdate
            , sellenddate
            , discontinueddate
            , modifieddate
            , category_name 
            , finishedgoodsflag   
        from product
    )

select * 
from product_dimension