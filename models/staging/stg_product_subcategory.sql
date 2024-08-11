with
    source as (
        select 
            -- Primary key
            productsubcategoryid as productsubcategory_pk
            -- Foreign key
            ,productcategoryid as productcategory_fk
            -- Stitch Columns
            ,name
        from {{ source('adventure_works', 'productsubcategory') }}
    )   
    
select *
from source