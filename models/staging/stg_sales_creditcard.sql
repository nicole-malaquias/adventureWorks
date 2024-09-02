with 
    source as (
        select
            -- Primary key
            creditcardid as creditcard_pk
            -- Other columns
            , cardtype
            , cardnumber
            , expmonth
            , expyear
            , modifieddate
        from {{ source('adventure_works', 'creditcard') }}
    )
select *
from source