with
    source as (
        select
            -- primary key
            purchaseorderid as purchaseorder_pk
            -- foreign keys
            , shipmethodid as shipmethod_fk
            -- other columns
            , revisionnumber
            -- transformar o status em uma descrição mais amigável
            , case 
                when status = 1 then 'pending'
                when status = 2 then 'approved'
                when status = 3 then 'rejected'
                when status = 4 then 'complete'
                else 'unknown'
            end as pur_status  
            , cast(orderdate as timestamp) as orderdate
            , cast(shipdate as timestamp) as shipdate
            , subtotal
            , taxamt
            , freight
            , subtotal + taxamt + freight as totaldue
        from {{ source('adventure_works', 'purchaseorderheader') }}
    )

select *
from source
