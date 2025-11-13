select
    c.card_key,
    c.card_id,
    c.card_name,
    c.super_type,
    c.img_url,
    s.set_key,
    a.artist_key
from {{ ref("init_cards") }} as c
left join {{ ref("init_sets") }} as s
    on c.set_id = s.set_id
left join {{ ref("init_artists") }} as a
    on c.artist_name = a.artist_name
order by card_key
