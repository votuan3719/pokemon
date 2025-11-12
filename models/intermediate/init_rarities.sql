with rarity as (
    select
        distinct rarity
    from {{ ref("stg_card_prices") }}
    where rarity is not null
    order by rarity
)
select
    row_number() over(order by rarity) as rarity_key,
    *
from rarity
order by rarity_key