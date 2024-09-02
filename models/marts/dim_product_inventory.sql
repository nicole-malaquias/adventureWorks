with 

    inventory as (
        select *
        from {{ ref('stg_product_inventory') }}
    )

    , product as (
        select *
        from {{ ref('stg_product') }}
    )

    , product_inventory_mapping as (
        select 
            -- Primary key
            {{ dbt_utils.surrogate_key(['product.product_pk', 'inventory.location_fk']) }} as inventory_sk
            -- Foreign key
            , {{ dbt_utils.surrogate_key(['product.product_pk','product.name']) }} as product_sk
            , inventory.shelf
            , inventory.bin
            , inventory.quantity
            , inventory.modifieddate
        from inventory
        left join product 
        on inventory.product_fk = product.product_pk
    )

select *
from product_inventory_mapping
