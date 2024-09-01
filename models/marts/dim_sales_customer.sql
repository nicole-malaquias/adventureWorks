with 
    stg_customer as (
        select *
        from {{ ref('stg_sales_customer') }}
    )
    
    , stg_person as (
        select *
        from {{ ref('stg_person_person') }}
    )
    
    , stg_store as (
        select *
        from {{ ref('stg_sales_store') }}
    )
    
    , stg_territory as (
        select *
        from {{ ref('stg_sales_territory') }}
    )
    
    , dim_customer as (
        select 
            -- Primary key (use relevant columns to generate a unique key)
            {{ dbt_utils.surrogate_key(['customer_pk']) }} as customer_pk
            
            -- Foreign keys
            , {{ dbt_utils.surrogate_key(['stg_person.person_pk']) }} as person_fk
            , COALESCE(stg_store.name, 'Online Store') as store_name
            , {{ dbt_utils.surrogate_key(['stg_territory.territory_pk']) }} as territory_fk
            
        from stg_customer
        left join stg_person
            on stg_customer.person_fk = stg_person.person_pk
        left join stg_store
            on stg_customer.store_fk = stg_store.store_pk
        left join stg_territory
            on stg_customer.territory_fk = stg_territory.territory_pk
    )

select *
from dim_customer