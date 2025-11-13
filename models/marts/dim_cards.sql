with cards as (
    select
        c.card_id,
        c.card_name,
        c.set_id,
        c.super_type,
        r.card_rarity,
        c.artist_name,
        c.img_url,
    from {{ ref("init_cards") }} as c
    cross join {{ ref("init_rarities") }} as r
),
card_rarities as (
    select distinct card_id, card_rarity
    from {{ ref("stg_card_prices") }}
),
unique_cards as (
    select 
        row_number() over(order by c.set_id, regexp_substr(c.card_id, '\\d+$')::int) as card_key,
        c.card_id,
        c.card_name,
        c.set_id,
        c.super_type,
        c.artist_name,
        c.img_url,
        c.card_rarity
    from card_rarities as cr
    left join cards as c
        on cr.card_id = c.card_id
        and cr.card_rarity = c.card_rarity
)
select 
    c.card_key as card_key,
    c.card_id as card_id,
    c.card_name as card_name,
    s.set_key as set_key,
    c.super_type as super_type,
    r.rarity_key as rarity_key,
    a.artist_key as artist_key,
    c.img_url as img_url
from unique_cards as c
left join {{ ref("init_sets") }} as s
    on c.set_id = s.set_id
left join {{ ref("init_rarities")}} as r
    on c.card_rarity = r.card_rarity
left join {{ ref("init_artists") }} as a
    on c.artist_name = a.artist_name
order by card_key, rarity_key

