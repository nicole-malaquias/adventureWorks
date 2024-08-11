

WITH
    date_array AS (
        SELECT
            date_add(DATE('2011-01-01'), INTERVAL day_number DAY) AS `date`
        FROM
            UNNEST(GENERATE_ARRAY(0, DATE_DIFF(DATE('2014-01-01'), DATE('2011-01-01'), DAY))) AS day_number
    ),
    date_dimension AS (
        SELECT
            `date`,
            EXTRACT(YEAR FROM `date`) AS year,
            EXTRACT(MONTH FROM `date`) AS month,
            EXTRACT(DAY FROM `date`) AS day_of_month,
            EXTRACT(DAYOFWEEK FROM `date`) AS day_of_week,
            CASE
                WHEN EXTRACT(DAYOFWEEK FROM `date`) IN (6, 7, 1) THEN
                    EXTRACT(WEEK FROM `date`)
                ELSE
                    EXTRACT(WEEK FROM DATE_SUB(`date`, INTERVAL 3 DAY))
            END AS initial_week_num
        FROM date_array
    ),
    year_week AS (
        SELECT
            *,
            CASE
                WHEN initial_week_num = 1 AND EXTRACT(MONTH FROM `date`) = 12 THEN initial_week_num
                WHEN initial_week_num >= 52 AND EXTRACT(MONTH FROM `date`) = 1 THEN initial_week_num
                ELSE initial_week_num
            END AS adjusted_week_num,
            CASE
                WHEN initial_week_num = 1 AND EXTRACT(MONTH FROM `date`) = 12 THEN year + 1
                WHEN initial_week_num >= 52 AND EXTRACT(MONTH FROM `date`) = 1 THEN year - 1
                ELSE year
            END AS adjusted_year
        FROM date_dimension
    )
    , week_in_month AS (
        SELECT
            *,
            CASE
                WHEN EXTRACT(DAYOFWEEK FROM `date`) IN (6, 7, 1) THEN CEIL(EXTRACT(DAY FROM `date`) / 7.0)
                ELSE CEIL((EXTRACT(DAY FROM `date`) - EXTRACT(DAYOFWEEK FROM `date`) + 5) / 7.0)
            END AS week_num_in_month
        FROM year_week
    )

select 
    *
from year_week
