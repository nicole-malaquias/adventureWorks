with 
    stg_creditcard as (
        select *
        from {{ ref('stg_sales_creditcard') }}
    )

    , surrogate_key as (
        select
            -- Primary Key
            {{ dbt_utils.surrogate_key(['stg_creditcard.creditcard_pk']) }} as creditcard_pk
            -- Other Columns
            , cardtype
            , cardnumber
            , expmonth
            , expyear
            , modifieddate
        from stg_creditcard
    )

select *
from surrogate_key