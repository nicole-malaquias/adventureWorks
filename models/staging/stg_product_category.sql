with
    source as (
        select 
            -- Primary key
            productcategoryid as productcategory_pk
            -- Others Columns
            , name
            , modifieddate
        from {{ source('adventure_works', 'productcategory') }}
    )   
    
select *
from source
