with cards as (
    select 
        card_id::varchar as card_id,
        card_name::varchar as card_name,
        set_id::varchar as set_id,
        super_type::varchar as super_type,
        artist_name::varchar as artist_name,
        img_url::varchar as img_url
    from {{ ref("stg_cards") }}
)
select 
    row_number() over(order by set_id, regexp_substr(card_id, '\\d+$')::int) as card_key,
    *
from cards
order by card_key