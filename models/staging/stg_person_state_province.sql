with 
    source as (
        select
            -- Primary key
            stateprovinceid as state_province_pk
            -- Foreign Key
            , countryregioncode as country_fk
            , territoryid as territory_fk
            -- Others Columns
            , name as province_name
            , isonlystateprovinceflag
            , stateprovincecode
        from {{ source('adventure_works', 'stateprovince') }}
    )
select *
from source