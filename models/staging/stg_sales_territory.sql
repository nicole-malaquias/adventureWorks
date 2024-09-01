with source as (
    select 
        -- primary key
        territoryid as territory_pk
        -- other columns
        , case 
            when countryregioncode = 'US' then concat('USA ', name)
            else name
        end as name
        , countryregioncode
        , `group` as group_territory
        , saleslastyear
        , costytd
        , costlastyear	
        , modifieddate
    from {{ source('adventure_works', 'salesterritory') }}
)

, country_name_cte as (
    select 
        *
        , case 
            when left(name, 3) = 'USA' then 'United States'
            else name
        end as country_name
    from source
)

select *
from country_name_cte