with 
    person as (
        select
            -- Primary key
            {{ dbt_utils.surrogate_key(['person_pk']) }} as person_pk
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