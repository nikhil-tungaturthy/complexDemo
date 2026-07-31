with valid_ids as (
    select *
    from {{ ref('slv_valid_starter_ids') }}
)

select
    count(*) as valid_id_count
from valid_ids
