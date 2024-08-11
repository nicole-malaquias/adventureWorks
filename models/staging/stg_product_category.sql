with
    source as (
        select 
            -- Primary key
            productcategoryid as productcategoryid_sk
            -- Stich Columns
            , name
            , modifieddate
        from {{ source('adventure_works', 'productcategory') }}
    )   
    
select *
from source
