with 
    stg_address as (
        select *
        from {{ ref('stg_person_address') }}
    )
    , stg_province as (
        select *
        from {{ ref('stg_person_state_province') }}
    )

    , stg_country as (
        select *
        from {{ ref('stg_person_country') }}
    )

    , dim_address as (
        select 
            -- Primary key
            {{ dbt_utils.surrogate_key(['stg_address.address_pk']) }} as address_pk

            -- Foreign Key
            , {{ dbt_utils.surrogate_key(['stg_province.state_province_pk']) }} as state_province_fk

            -- Other Columns
            , stg_address.addressline1
            , stg_address.addressline2
            , stg_address.city
            , stg_address.postalcode
            , stg_address.spatiallocation
            , stg_province.province_name
            , stg_country.name as country_name
        from stg_address
        left join stg_province
        on stg_address.state_province_fk = stg_province.state_province_pk
        left join stg_country
        on stg_province.country_fk = stg_country.country_pk
    )

select *
from dim_address