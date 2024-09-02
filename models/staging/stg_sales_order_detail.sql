with
    source as (
        select 
            -- Primary Key
            salesorderdetailid as salesorderdetail_pk
            -- Foreign Key
            , salesorderid as salesorder_fk
            , productid as product_fk
            , specialofferid as specialoffer_fk
            -- Others Columns
            , carriertrackingnumber
            , orderqty
            , unitprice
            , unitpricediscount
            , modifieddate 
        from {{ source('adventure_works', 'salesorderdetail') }}
    )   

select *
from source
