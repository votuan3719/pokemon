with artists as (
    select
        distinct artist
    from {{ ref("stg_cards") }}
    order by artist
)
select
    row_number() over(order by artist) as artist_key,
    *
from artists
where artist is not null
order by artist_key