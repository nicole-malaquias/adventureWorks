with 
    source as (
        select 
            -- Primary Key
            businessentityid as salesperson_pk
            -- Foreign Key
            , territoryid as territory_fk
            -- Others Columns
            , salesquota
            , bonus 
            , commissionpct as commissionpct
            , salesytd as salesytd
            , saleslastyear as saleslastyear
            , modifieddate   
        from {{ source('adventure_works', 'salesperson') }}
    )   

select * 
from source
