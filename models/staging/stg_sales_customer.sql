with source as (
    select
        -- Primary key
        customerid as customer_pk
        -- Foreign keys
        , personid as person_fk
        , storeid as store_fk
        , territoryid as territory_fk
    from {{ source('adventure_works', 'customer') }}
    )
select *
from source	