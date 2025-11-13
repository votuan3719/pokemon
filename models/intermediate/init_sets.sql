with pokemon_sets as (
    select
        set_id::varchar as set_id,
        set_name::varchar as set_name,
        series_name::varchar as series_name,
        printed_total::int as printed_total,
        to_date(release_date::varchar, 'YYYY/MM/DD') as release_date,
        logo_url::varchar as logo_url
    from {{ ref("stg_sets") }}
)
select 
    row_number() over(order by release_date) as set_key,
    *
from pokemon_sets
order by set_key