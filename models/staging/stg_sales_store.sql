with    
    source as (
        select 
            -- Primary key
            businessentityid as store_pk
            -- Others Columns
            , name
            , demographics
        from {{ source('adventure_works', 'store') }}
    )

select * 
from source 