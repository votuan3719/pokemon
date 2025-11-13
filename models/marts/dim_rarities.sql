select
    *
from {{ ref("init_rarities") }}
order by rarity_key