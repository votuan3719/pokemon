select
    c.card_key::int as card_key,
    c.card_id::varchar as card_id,
    c.name::varchar as card_name,
    c.supertype::varchar as supertype,
    c.artist::varchar as artist,
    c.img_url::varchar as img_url
from {{ ref("init_cards") }} as c
order by card_key
