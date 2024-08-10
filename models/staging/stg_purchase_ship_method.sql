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

            -- Surrogate Key
            , rowguid as rowguid_sk

        from {{ source('adventure_works', 'shipmethod') }}
    )

select *
from source 