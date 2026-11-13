select distinct
    product || ' | ' || coalesce(sub_product, '(none)')    as product_key,
    product,
    sub_product
from {{ ref('int_complaints__products_remapped') }}