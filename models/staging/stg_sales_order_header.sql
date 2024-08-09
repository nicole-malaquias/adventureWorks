with 
    source as (
    select 

            -- Primary Key
            salesorderid

            -- Foreign Key
            , creditcardid
            , customerid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , shipmethodid
            , currencyrateid

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