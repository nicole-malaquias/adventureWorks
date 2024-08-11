with
    source as (
        select
            -- Primary Key
            purchaseorderid as purchaseorderdetail_pk
            -- Foreign Keys
            , purchaseorderdetailid as purchaseorderdetail_fk
            , productid as product_fk
            -- Stich Columns
            , cast(duedate as timestamp) as duedate
            , orderqty
            , unitprice
            , receivedqty
            , rejectedqty
            , modifieddate
        from {{ source('adventure_works', 'purchaseorderdetail') }}
    )

select *
from source 