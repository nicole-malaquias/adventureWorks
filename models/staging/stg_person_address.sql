with 
    source as (
        select
            -- Primary key
            addressid as address_pk
            -- Foreign keys
            , stateprovinceid as state_province_fk
            -- Others Columns
            , city
            , addressline1	
            , addressline2
            , postalcode
            , spatiallocation
        from {{ source('adventure_works', 'address') }}
    )
select *
from source