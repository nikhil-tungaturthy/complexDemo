with source_data as (
    select *
    from {{ source('starter_demo', 'starter_ids') }}
)

select
    id,
    id is not null as is_valid_id
from source_data
