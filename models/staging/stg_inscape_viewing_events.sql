with source_data as (
    select *
    from {{ source('inscape_raw', 'viewing_events') }}
),

deduplicated_events as (
    select
        *,
        row_number() over (
            partition by event_id
            order by _loaded_at desc
        ) as event_version
    from source_data
)

select
    event_id,
    inscape_tv_key,
    start_viewed_datetime::timestamp_ntz as start_viewed_datetime,
    end_viewed_datetime::timestamp_ntz as end_viewed_datetime,
    lower(trim(network)) as network,
    lower(trim(title)) as title,
    lower(trim(input_device)) as input_device,
    lower(trim(app_service)) as app_service,
    case
        when upper(trim(live::varchar)) in ('1', 'Y', 'TRUE') then true
        when upper(trim(live::varchar)) in ('0', 'N', 'FALSE') then false
    end as is_live,
    _loaded_at::timestamp_ntz as loaded_at
from deduplicated_events
where event_version = 1
