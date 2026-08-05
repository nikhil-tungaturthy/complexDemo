with media_events as (
    select *
    from {{ ref('int_inscape_media_events') }}
)

select
    event_id,
    to_date(start_viewed_datetime) as partition_date,
    to_date(start_viewed_datetime) as viewed_date,
    blu_id,
    inscape_tv_key,
    start_viewed_datetime,
    total_seconds,
    end_viewed_datetime,
    network,
    title,
    genre,
    input_device,
    app_service,
    is_live as live,
    blu_genre,
    media_type,
    behavior_cultural_index,
    behavior_traits
from media_events
