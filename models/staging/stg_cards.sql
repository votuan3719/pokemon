select 
    pokemon.value:id as card_id,
    pokemon.value:name as name,
    pokemon.value:supertype as supertype,
    pokemon.value:artist as artist,
    pokemon.value:image as img_url
from {{ source("pokemon", "tcg_pokemon_api") }},
    lateral flatten (json_data) pokemon
