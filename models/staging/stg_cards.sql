select 
    json_data:id as card_id,
    json_data:name as name,
    json_data:supertype as supertype,
    json_data:artist as artist
from {{ source("dbt_pokemon", "tcg_pokemon_api") }}