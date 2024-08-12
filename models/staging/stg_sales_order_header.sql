with 
    source as (
        select 
            -- Primary Key
            salesorderid as salesorder_pk
            -- Foreign Key
            , creditcardid as creditcard_fk
            , customerid as customer_fk
            , territoryid as territory_fk
            , salespersonid as salesperson_fk
            , billtoaddressid as billtoaddress_fk
            , shiptoaddressid as shiptoaddress_fk
            , shipmethodid as shipmethod_fk
            , currencyrateid as currencyrate_fk
            -- Others Columns
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