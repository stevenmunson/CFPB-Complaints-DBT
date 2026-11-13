-- Fixes the August 2023 product change. Before then, credit cards and prepaid
-- cards shared one product, "Credit card or prepaid card". This model splits it
-- by sub-product using the product_mapping seed, then keeps only the four
-- products this project covers.

with complaints as (

    select * from {{ ref('stg_cfpb__complaints') }}

),

product_mapping as (

    select * from {{ ref('product_mapping') }}

),

remapped as (

    select
        complaints.* exclude (product),
        case
            when complaints.product = 'Credit card or prepaid card'
                then product_mapping.new_product
            else complaints.product
        end as product
    from complaints
    left join product_mapping
        on complaints.product = product_mapping.old_product
       and complaints.sub_product = product_mapping.old_sub_product

)

select * from remapped
-- "is distinct from" keeps NULLs, so an unmapped sub-product
-- reaches the not_null test instead of silently disappearing
where product is distinct from 'Prepaid card'