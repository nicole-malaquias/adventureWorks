with
    source as (
        select 
            -- Primary key
            productcategoryid as productcategory_pk
            -- Stich Columns
            , name
            , modifieddate
        from {{ source('adventure_works', 'productcategory') }}
    )   
    
select *
from source
