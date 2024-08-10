with
    source as (
        select 
            -- Primary Key
            productid as productid_sk

            -- Foreign Key
            , productsubcategoryid as productsubcategory_fk
            , productmodelid as productmodel_fk

            -- Stitch Columns
            , name
            , productnumber
            , makeflag
            , finishedgoodsflag
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
            , sellstartdate
            , sellenddate
            , discontinueddate
            , modifieddate
            
        from {{ source('adventure_works', 'product') }}
    )   

select *
from source
