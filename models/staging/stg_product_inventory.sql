with
    source as (
        select 
    
            -- Foreign Key
             productid as product_fk
            , locationid as location_fk

            -- Stich Columns
            , shelf
            , bin
            , quantity
            , modifieddate
            
            -- Surrogate Key
            , rowguid
        from {{ source('adventure_works', 'productinventory') }}
    )   
    
select *
from source
