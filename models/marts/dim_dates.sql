with
    date_array as (
        select
            date_add(date('2011-01-01'), interval day_number day) as `date`
        from
            unnest(generate_array(0, date_diff(date('2014-01-01'), date('2011-01-01'), day))) as day_number
    )
    
    , date_dimension as (
        select
            `date`
            , extract(year from `date`) as year
            , extract(month from `date`) as month
            , extract(day from `date`) as day_of_month
            , extract(dayofweek from `date`) as day_of_week
            , case
                when extract(dayofweek from `date`) in (6, 7, 1) then
                    extract(week from `date`)
                else
                    extract(week from date_sub(`date`, interval 3 day))
            end as initial_week_num
        from date_array
    )

    , year_week as (
        select *
            , case
                when initial_week_num = 1 and extract(month from `date`) = 12 then initial_week_num
                when initial_week_num >= 52 and extract(month from `date`) = 1 then initial_week_num
                else initial_week_num
            end as adjusted_week_num
            , case
                when initial_week_num = 1 and extract(month from `date`) = 12 then year + 1
                when initial_week_num >= 52 and extract(month from `date`) = 1 then year - 1
                else year
            end as adjusted_year
        from date_dimension
    )

    , week_in_month as (
        select *
            , case
                when extract(dayofweek from `date`) in (6, 7, 1) then ceil(extract(day from `date`) / 7.0)
                else ceil((extract(day from `date`) - extract(dayofweek from `date`) + 5) / 7.0)
            end as week_num_in_month
        from year_week
    )

select 
    *
from year_week;