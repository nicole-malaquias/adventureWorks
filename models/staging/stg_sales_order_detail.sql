with
    source as (
    select 
        -- Primary Key
        salesorderdetailid_sk

        -- Foreign Key
        , salesorderid_fk
        , productid_fk
        , specialofferid_fk

        -- Stich Columns
        , carriertrackingnumber
        , orderqty
        , unitprice
        , unitpricediscount
        , rowguid_sk
        , modifieddate

    from {{ source('adventure_works', 'salesorderdetail') }}
    )   

select *
from source
