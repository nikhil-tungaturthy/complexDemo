with source_data as (
    select *
    from {{ source('inscape_raw', 'blu_device_graph') }}
)

select
    inscape_tv_key,
    blu_id,
    household_id,
    device_first_seen_date::date as device_first_seen_date,
    match_confidence
from source_data
