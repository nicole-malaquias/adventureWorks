with 
    source as (
        select 
            -- Primary Key
            territoryid	as territory_pk
            
            -- Stitch Columns
            , name	
            , countryregioncode	
            , `group` as group_territory
            , salesytd
            , saleslastyear
            , costytd
            , costlastyear	
            , modifieddate

        from {{ source('adventure_works', 'salesterritory') }}
    )

select *
from source
