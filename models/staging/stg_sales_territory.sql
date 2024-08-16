with source as (
    select 
        -- Primary Key
        territoryid as territory_pk
        -- Other Columns
        , name
        , countryregioncode
        , case 
            when countryregioncode = 'US' then concat('US ', `group`)
            else `group`
        end as group_territory
        , saleslastyear
        , costytd
        , costlastyear	
        , modifieddate
    from {{ source('adventure_works', 'salesterritory') }}
)

select *
from source
