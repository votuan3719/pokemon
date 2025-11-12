with artists as (
    select
        distinct artist
    from {{ ref("stg_cards") }}
    where artist is not null
    order by artist
)
select
    row_number() over(order by artist) as artist_key,
    *
from artists
order by artist_key