with 
    stg_territory as (
        select *
        from {{ ref('stg_sales_territory')}}
    )

    , dim_territory as (
        select 
            -- Primary Key
            {{ dbt_utils.surrogate_key(['territory_pk']) }} as territory_pk
            -- Other Columns
            , name
            , country_name
            , countryregioncode
            , group_territory
            , saleslastyear
            , costytd
            , costlastyear
        from stg_territory
    )

select *
from dim_territory
