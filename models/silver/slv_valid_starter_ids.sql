with bronze_ids as (
    select *
    from {{ ref('brz_starter_ids') }}
)

select
    id
from bronze_ids
where is_valid_id
