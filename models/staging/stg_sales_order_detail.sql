with
    source as (
    select 
        -- Primary Key
        salesorderdetailid

        -- Foreign Key
        , salesorderid
        , productid
        , specialofferid

        -- Stich Columns
        , carriertrackingnumber
        , orderqty
        , unitprice
        , unitpricediscount
        , rowguid
        , modifieddate

    from {{ source('adventure_works', 'salesorderdetail') }}
    )   

select *
from source
