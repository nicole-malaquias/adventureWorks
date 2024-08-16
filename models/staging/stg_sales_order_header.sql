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
            , case
                when status = 1 then 'In process'
                when status = 2 then 'Approved'
                when status = 3 then 'Backordered'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Cancelled'
                else 'Unknown'
              end as status_description
            , onlineorderflag
            , accountnumber
            , creditcardapprovalcode
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{ source('adventure_works', 'salesorderheader') }}
    )   

select * 
from source