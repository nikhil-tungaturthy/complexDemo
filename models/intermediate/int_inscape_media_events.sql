with viewing_events as (
    select *
    from {{ ref('stg_inscape_viewing_events') }}
    where end_viewed_datetime is not null
        and end_viewed_datetime >= start_viewed_datetime
),

device_graph as (
    select *
    from {{ ref('stg_blu_device_graph') }}
),

title_metadata as (
    select *
    from {{ ref('stg_blu_title_metadata') }}
)

select
    viewing_events.event_id,
    viewing_events.inscape_tv_key,
    device_graph.blu_id,
    viewing_events.start_viewed_datetime,
    viewing_events.end_viewed_datetime,
    datediff('second', viewing_events.start_viewed_datetime, viewing_events.end_viewed_datetime) as total_seconds,
    viewing_events.network,
    viewing_events.title,
    title_metadata.genre,
    viewing_events.input_device,
    viewing_events.app_service,
    viewing_events.is_live,
    title_metadata.blu_genre,
    title_metadata.media_type,
    title_metadata.behavior_cultural_index,
    title_metadata.behavior_traits
from viewing_events
inner join device_graph
    on viewing_events.inscape_tv_key = device_graph.inscape_tv_key
    and device_graph.blu_id is not null
left join title_metadata
    on viewing_events.title = title_metadata.title
    and viewing_events.network = title_metadata.network
