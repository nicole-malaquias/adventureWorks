with 
    source as (
    select 
        -- Primary Key
        businessentityid as salesperson_pk

        -- Foreign Key
        , territoryid as territory_fk

        -- Stitch Columns
        , salesquota
        , bonus 
        , commissionpct as commissionpct
        , salesytd as salesytd
        , saleslastyear as saleslastyear
        , rowguid  -- Corrigido de rowguid_sk para rowguid
        , modifieddate
    from {{ source('adventure_works', 'salesperson') }}
    )   

select * 
from source
