with 
    method as (
        select *
        from {{ ref('stg_purchase_ship_method') }}
    )

    , shipmethod_dimension as (
        select 
            -- Primary Key
            {{ dbt_utils.surrogate_key(['shipmethod_pk']) }} as shipmethod_pk
            -- Other Columns
            , name
            , shipbase
            , shiprate
        from method
    )

select *
from shipmethod_dimension