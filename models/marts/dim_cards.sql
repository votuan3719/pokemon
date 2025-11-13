with rarities as (
    select
        c.card_key,
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
    select distinct card_key, card_rarity
    from {{ ref("init_card_prices") }}
),
cards as (
    select 
        row_number() over(order by cr.card_key, cr.card_rarity) as card_key,
        r.card_id,
        r.card_name,
        r.set_id,
        r.super_type,
        r.artist_name,
        r.img_url,
        r.card_rarity
    from card_rarities as cr
    left join rarities as r
        on cr.card_key = r.card_key
        and cr.card_rarity = r.card_rarity
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
from cards as c
left join {{ ref("init_sets") }} as s
    on c.set_id = s.set_id
left join {{ ref("init_rarities")}} as r
    on c.card_rarity = r.card_rarity
left join {{ ref("init_artists") }} as a
    on c.artist_name = a.artist_name
order by card_key, rarity_key

