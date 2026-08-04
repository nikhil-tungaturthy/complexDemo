with source_data as (
    select *
    from {{ source('inscape_raw', 'blu_title_metadata') }}
)

select
    lower(trim(title)) as title,
    lower(trim(network)) as network,
    genre,
    blu_genre,
    media_type,
    behavior_cultural_index,
    behavior_traits,
    load_timestamp::timestamp_ntz as loaded_at
from source_data
