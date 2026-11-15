select distinct
    {{ make_key('product', 'sub_product') }} as product_key,
    product,
    sub_product
from {{ ref('int_complaints__products_remapped') }}
