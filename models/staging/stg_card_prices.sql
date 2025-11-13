with cards as (
    select
        card.value:cardId as card_id,
        card.value:set.id as set_id,
        card.value:tcg,
        card.value:tcgplayerHistory.priceHistory._doc as tcg_history
    from {{ source("pokemon", "price_tracker_api") }},
        lateral flatten (json_data) card
),
rarities as (
    select
        card_id,
        set_id,
        rarity.key as card_rarity,
        rarity.value:low as price_low,
        rarity.value:mid as price_mid,
        rarity.value:high as price_high,
        rarity.value:market as price_market
    from cards,
        lateral flatten (tcg_history) rarity
),
low_prices as (
    select
        card_id,
        set_id,
        card_rarity,
        low.value:date as date,
        low.value:price as price_low
    from rarities,
        lateral flatten (price_low) as low
),
mid_prices as (
    select
        card_id,
        set_id,
        card_rarity,
        mid.value:date as date,
        mid.value:price as price_mid
    from rarities,
        lateral flatten (price_mid) as mid
),
high_prices as (
    select
        card_id,
        set_id,
        card_rarity,
        high.value:date as date,
        high.value:price as price_high
    from rarities,
        lateral flatten (price_high) as high
),
market_prices as (
    select
        card_id,
        set_id,
        card_rarity,
        market.value:date as date,
        market.value:price as price_market
    from rarities,
        lateral flatten (price_market) market
),
prices as (
    select *
    from low_prices
    join mid_prices
        using(card_id, set_id, card_rarity, date)
    join high_prices
        using(card_id, set_id, card_rarity, date)
    join market_prices
        using(card_id, set_id, card_rarity, date)
)
select 
    * 
from prices
order by set_id, card_id, card_rarity, date