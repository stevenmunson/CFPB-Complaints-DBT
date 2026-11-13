-- Every state code that appears in the complaints, with population where the
-- Census has it. Territories and military codes (like AE) have no population.

with state_codes as (

    select distinct state_code
    from {{ ref('int_complaints__products_remapped') }}
    where state_code is not null
)

select
    state_codes.state_code,
    state_population.state_name,
    state_population.population,
from state_codes
left join {{ ref('state_population') }} as state_population
    on state_codes.state_code = state_population.state_code