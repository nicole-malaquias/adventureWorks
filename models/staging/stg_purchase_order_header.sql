with
    source as (
        select
            -- Primary Key
            purchaseorderid as purchaseorder_pk
            -- Foreign Keys
            , shipmethodid as shipmethod_fk
            -- Others Columns
            , revisionnumber
            , status
            , cast(orderdate as timestamp) as orderdate
            , cast(shipdate as timestamp) as shipdate
            , subtotal
            , taxamt
            , freight
        from {{ source('adventure_works', 'purchaseorderheader') }}
    )

select *
from source 