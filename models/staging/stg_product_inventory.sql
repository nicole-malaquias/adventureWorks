with
    source as (
        select 
            -- Foreign Key
             productid as product_fk
            , locationid as location_fk
            -- Others Columns
            , shelf
            , bin
            , quantity
            , modifieddate
        from {{ source('adventure_works', 'productinventory') }}
    )   
    
select *
from source
