WITH distinct_group_territory AS (
    SELECT DISTINCT group_territory
    FROM {{ ref('dim_sales_territory') }}
)

SELECT *
FROM distinct_group_territory
WHERE group_territory NOT IN ('Europe', 'North America', 'Pacific')