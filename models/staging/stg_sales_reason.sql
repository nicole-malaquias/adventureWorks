with source_data as (
    select
        -- Primary Key
        salesreasonid as reason_pk
        -- Other Columns
        , name as reason_name
        , reasontype
        , modifieddate
    from {{ source('adventure_works', 'salesreason') }}
)
select *
from source_data