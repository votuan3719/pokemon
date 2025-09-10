select distinct
    json_data:rarity
from {{ source("dbt_pokemon", "tcg_pokemon_api") }}