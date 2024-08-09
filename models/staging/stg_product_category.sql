with
    source as (
        select 
            -- Primary key
            productcategoryid as productcategoryid_sk

            -- Stich Columns
            , name
            , modifieddate

            -- Surrogate key
            , rowguid as rowguid_sk
            
        from {{ source('adventure_works', 'productcategory') }}
    )   
    
select *
from source
