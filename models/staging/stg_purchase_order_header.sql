with
    source as (
        select
            -- Primary Key
            purchaseorderid as purchaseorder_sk

            -- Foreign Keys
            , employeeid as employee_fk
            , vendorid as vendor_fk
            , shipmethodid as shipmethod_fk

            -- Stich Columns
            , revisionnumber
            , status
            , orderdate
            , shipdate
            , subtotal
            , taxamt
            , freight
            , modifieddate
        from {{ source('adventure_works', 'purchaseorderheader') }}
    )

select *
from source 