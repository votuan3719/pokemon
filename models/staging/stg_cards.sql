select 
    pokemon.value:id as card_id,
    pokemon.value:name as card_name,
    pokemon.value:set_id as set_id,
    pokemon.value:supertype as super_type,
    pokemon.value:artist as artist_name,
    pokemon.value:image as img_url
from {{ source("pokemon", "tcg_pokemon_api") }},
    lateral flatten (json_data) pokemon

