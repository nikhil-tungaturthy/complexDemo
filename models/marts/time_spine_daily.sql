{{
    config(
        materialized = 'table'
    )
}}

with date_spine as (

    {{
        dbt.date_spine(
            datepart = 'day',
            start_date = "to_date('2000-01-01')",
            end_date = "dateadd(year, 1, current_date())"
        )
    }}

)

select
    cast(date_day as date) as date_day
from date_spine
