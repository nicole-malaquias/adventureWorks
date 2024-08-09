with 
    source as (
    select 
        -- Primary Key
        salesorderid_pk

        -- Foreign Key
        , creditcardid_fk
        , customerid_fk
        , territoryid_fk
        , billtoaddressid_fk
        , shiptoaddressid_fk
        , shipmethodid_fk
        , currencyrateid_fk

        -- Stich Columns
        , cast(orderdate as timestamp) as orderdate
        , cast(duedate as timestamp) as duedate
        , cast(shipdate as timestamp) as shipdate
        , status
        , onlineorderflag
        , accountnumber
        , creditcardapprovalcode
        , subtotal
        , taxamt   
    from {{ source('adventure_works', 'salesorderheader') }}
    )   

select * 
from source