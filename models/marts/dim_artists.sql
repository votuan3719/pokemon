select 
    *
from {{ ref("init_artists") }}
order by artist_key