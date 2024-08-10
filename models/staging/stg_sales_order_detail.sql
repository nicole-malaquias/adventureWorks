with
    source as (
        select 
            -- Primary Key
            salesorderdetailid as salesorderdetail_pk
            -- Foreign Key
            , salesorderid as salesorder_pk
            , productid as product_pk
            , specialofferid as specialoffer_pk
            -- Stich Columns
            , carriertrackingnumber
            , orderqty
            , unitprice
            , unitpricediscount
            , modifieddate 
        from {{ source('adventure_works', 'salesorderdetail') }}
    )   

select *
from source
