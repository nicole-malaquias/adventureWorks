with 
    product as (
        select *
        from {{ ref('stg_product') }}
    ) 

    , category as (
        select *
        from {{ ref('stg_product_category') }}
    )

    , subcategory as (
        select *
        from {{ ref('stg_product_subcategory') }}
    )

    , join_product as (
        select 
            product.product_pk
            , product.productsubcategory_fk
            , product.name
            , product.productnumber
            , product.color
            , product.safetystocklevel
            , product.reorderpoint
            , product.standardcost
            , product.daystomanufacture
            , product.productline
            , product.class
            , product.style
            , product.sellstartdate
            , product.sellenddate
            , product.discontinueddate
            , product.modifieddate
            , category.name as original_category_name
        from product
        left join subcategory
            on product.productsubcategory_fk = subcategory.productsubcategory_pk
        left join category
            on subcategory.productcategory_fk = category.productcategory_pk
    )
   
    , categorized_product as (
    select 
        product_pk
        , case
            when original_category_name is null and (
                name like '%panniers%' or 
                name like '%lock%' or 
                name like '%hub%' or 
                name like '%bearing%' or
                name like '%caps%' or 
                name like '%stem%' or
                name like '%steerer%'
            ) then 'accessories'
            
            when original_category_name is null and (
                name like '%road%' and 
                name like '%-%'
            ) then 'bikes'
            
            when original_category_name is null and (
                name like '%frame%' or 
                name like '%tube%' or 
                name like '%fork%' or 
                name like '%crown%' or 
                name like '%stays%' or 
                name like '%blade%' or 
                name like '%seat%' or
                name like '%chain%' or
                name like '%ball%' or
                daystomanufacture = 0
            ) then 'components'
            
            when original_category_name is null and (
                name like '%socks%' or 
                name like '%cap%' or 
                name like '%jersey%' or 
                name like '%seat%' or 
                name like '%assembly%'
            ) then 'clothing'
            
            else coalesce(original_category_name, 'components')
        end as category_name
    from join_product
    )

    , join_category as (
        select 
            product.product_pk
            , product.name
            , categorized_product.category_name
            , product.productnumber
            , product.color
            , product.safetystocklevel
            , product.reorderpoint
            , product.standardcost
            , product.daystomanufacture
            , product.productline
            , product.class
            , product.style
            , product.sellstartdate
            , product.sellenddate
            , product.discontinueddate
            , product.modifieddate
        from join_product as product
        left join categorized_product
            on product.product_pk = categorized_product.product_pk
    )

select *
from join_category