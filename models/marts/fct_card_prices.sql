with prices as (
        select
            c.card_key::int as card_key,
            p.date::date as date,
            p.price_low::float as price_low,
            p.price_mid::float as price_mid,
            p.price_high::float as price_high,
            p.price_market::float as price_market
        from {{ ref("dim_cards") }} as c
        left join {{ ref("dim_rarities")}} as r
            on c.rarity_key = r.rarity_key
        left join {{ ref("stg_card_prices") }} as p
            on c.card_id = p.card_id
            and r.card_rarity = p.card_rarity
)
select * 
from prices
order by card_key, date
