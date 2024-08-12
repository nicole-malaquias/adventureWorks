with
    source as (
        select
            -- Primary key
            shipmethodid as shipmethod_pk
            -- Others Columns
            , name
            , shipbase
            , shiprate
            , modifieddate
        from {{ source('adventure_works', 'shipmethod') }}
    )

select *
from source 