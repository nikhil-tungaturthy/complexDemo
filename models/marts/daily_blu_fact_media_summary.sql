with media_events as (
    select *
    from {{ ref('int_inscape_media_events') }}
),

daily_summary as (
    select
        to_date(start_viewed_datetime) as partition_date,
        to_date(start_viewed_datetime) as viewed_date,
        blu_id,
        array_agg(distinct network) within group (order by network) as network_array,
        array_agg(distinct title) within group (order by title) as title_array,
        array_agg(distinct genre) within group (order by genre) as genre_array,
        array_agg(distinct input_device) within group (order by input_device) as input_device_array,
        array_agg(distinct app_service) within group (order by app_service) as app_service_array
    from media_events
    group by 1, 2, 3
)

select
    partition_date,
    viewed_date,
    blu_id,
    network_array,
    title_array,
    genre_array,
    input_device_array,
    app_service_array,
    array_to_string(network_array, ', ') as network_str_list,
    array_to_string(title_array, ', ') as title_str_list,
    array_to_string(genre_array, ', ') as genre_str_list,
    array_to_string(input_device_array, ', ') as input_device_str_list,
    array_to_string(app_service_array, ', ') as app_service_str_list
from daily_summary
