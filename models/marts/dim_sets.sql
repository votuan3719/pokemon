select
    *
from {{ ref("init_sets") }}
order by set_key