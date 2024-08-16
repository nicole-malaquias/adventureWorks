with 
    source as (
        select *
        from {{ source('adventure_works', 'countryregion') }}
    )

    , stg_person_country as (
        select 
            countryregioncode as country_pk 
            , name 
        from source
    )

select *
from stg_person_country