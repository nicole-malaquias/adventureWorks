with
    source as (
        select
            -- Primary Key
            purchaseorderdetailid as purchaseorderdetail_pk
            -- Foreign Keys
            , purchaseorderid as purchaseorder_fk
            , productid as product_fk
            -- Others Columns
            , cast(duedate as timestamp) as due_date
            , orderqty as order_qty
            , unitprice as unit_price
            , receivedqty as received_qty
            , rejectedqty as rejected_qty
        from {{ source('adventure_works', 'purchaseorderdetail') }}
    )

select *
from source 