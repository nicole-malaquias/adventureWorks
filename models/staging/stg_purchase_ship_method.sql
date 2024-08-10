with
    source as (
        select

            -- Primary key
            shipmethodid

            -- Stich Columns
            , name
            , shipbase
            , shiprate
            , modifieddate

        from {{ source('adventure_works', 'shipmethod') }}
    )

select *
from source 