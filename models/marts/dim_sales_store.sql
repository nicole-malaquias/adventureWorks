with 
    stg_store as (
        select *
        from {{ ref('stg_sales_store') }} 
    )
    
    , dim_store as (
        select 
            -- Primary key
            {{ dbt_utils.surrogate_key(['store_pk']) }} as store_pk
            -- Other Columns
            , name
            , demographics
        from stg_store
    )

select *
from dim_store
