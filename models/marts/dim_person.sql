with 
    person as (
        select
            -- Primary key
            {{ dbt_utils.surrogate_key(['person_pk','full_name']) }} as person_sk
            -- Others Columns
            , full_name
            , title
            , firstname
            , middlename
            , lastname
            , persontype_description
            , namestyle_description
            , suffix
            , emailpromotion
        from {{ ref('stg_person_person') }}
    )

select *
from person