with 
    source as (
        select
            -- Primary key
            businessentityid as person_pk
            -- Others Columns
            , title
            , firstname
            , middlename
            , lastname
            , persontype 
            , namestyle
            , suffix
            , modifieddate
            , rowguid
            , emailpromotion
        from {{ source('adventure_works', 'person') }}
    ),
    treated_source as (
        select
            person_pk
            , title
            , concat(firstname, ' ', lastname) as full_name
            , firstname
            , middlename
            , lastname
            , case 
                when persontype = 'SC' then 'Store Contact'
                when persontype = 'IN' then 'Individual'
                when persontype = 'SP' then 'Sales Person'
                when persontype = 'EM' then 'Employee'
                when persontype = 'VC' then 'Vendor Contact'
                when persontype = 'GC' then 'General Contact'
                else 'Unknown'
              end as persontype_description
            , case 
                when namestyle = false then 'Western'
                when namestyle = true then 'Eastern'
                else 'Unknown'
              end as namestyle_description
            , suffix
            , modifieddate
            , rowguid
            , emailpromotion
        from source
    )
select *
from treated_source