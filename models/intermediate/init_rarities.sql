with rarities as (
    select
        distinct card_rarity::varchar as card_rarity
    from {{ ref("stg_card_prices") }}
    where card_rarity is not null
)
select
    row_number() over(order by card_rarity) as rarity_key,
    *
from rarities
order by rarity_key