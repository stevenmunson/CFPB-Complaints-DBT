-- One row per day from 2023 through 2026, built with dbt_utils.date_spine.
-- The end date is exclusive, so 2027-01-01 means "up to Dec 31, 2026."

with days as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2023-01-01' as date)",
        end_date="cast('2027-01-01' as date)"
    ) }}

)

select
    cast(date_day as date)                      as date_day,
    year(date_day)                              as year,
    quarter(date_day)                           as quarter,
    month(date_day)                             as month_number,
    strftime(date_day, '%b')                    as month_name,
    cast(date_trunc('month', date_day) as date) as month_start,
    dayofweek(date_day)                         as day_of_week_number,
    strftime(date_day, '%a')                    as day_name
from days