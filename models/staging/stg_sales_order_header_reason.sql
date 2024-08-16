with source_data as (
    select
        -- Primary key
        row_number() over (order by salesorderid) as order_reason_pk
        -- Foreign key
        , salesreasonid as reason_fk
        , salesorderid as order_head_fk
    from {{ source('adventure_works', 'salesorderheadersalesreason') }}
)
select *
from source_data