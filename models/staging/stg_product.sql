with
    source as (
        select 
            -- Primary Key
            productid as product_pk
            -- Foreign Key
            , productsubcategoryid as productsubcategory_fk
            , productmodelid as productmodel_fk
            -- Others Columns
            , name
            , productnumber
            , color
            , safetystocklevel
            , reorderpoint
            , standardcost
            , listprice
            , size
            , sizeunitmeasurecode
            , weightunitmeasurecode
            , weight
            , daystomanufacture
            , productline
            , class
            , style
            , cast(sellstartdate as timestamp) as sellstartdate
            , cast(sellenddate as timestamp) as sellenddate
            , discontinueddate
            , modifieddate
        from {{ source('adventure_works', 'product') }}
    )   

select *
from source
