with artists as (
    select
        distinct artist_name
    from {{ ref("init_cards") }}
    where artist_name is not null
)
select
    row_number() over(order by artist_name) as artist_key,
    *
from artists
order by artist_key