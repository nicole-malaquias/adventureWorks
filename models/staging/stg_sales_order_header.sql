with 
    source as (
    select 
        -- Primary Key
        salesorderid as salesorder_pk

        -- Foreign Key
        , creditcardid as creditcard_pk
        , customerid as customer_pk
        , territoryid as territory_pk
        , billtoaddressid as billtoaddress_pk
        , shiptoaddressid as shiptoaddress_pk
        , shipmethodid as shipmethod_pk
        , currencyrateid as currencyrate_pk

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