with prices as (
        select
            c.card_key::int as card_key,
            p.date::date as date,
            p.price_low::float as price_low,
            p.price_mid::float as price_mid,
            p.price_high::float as price_high,
            p.price_market::float as price_market
        from {{ ref("stg_card_prices") }} as p
        left join {{ ref("init_cards") }} as c 
            on p.card_id = c.card_id
    )
select * from prices
order by card_key, date
