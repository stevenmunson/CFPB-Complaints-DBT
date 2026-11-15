with complaints as (

    select * from {{ ref('int_complaints__products_remapped') }}

)

select
    -- keys
    complaint_id,
    {{ make_key('product', 'sub_product') }} as product_key,
    {{ make_key('issue', 'sub_issue') }} as issue_key,
    company_name,
    state_code,
    submitted_via,

    -- dates
    date_received,
    date_sent_to_company,
    date_sent_to_company - date_received     as days_to_send_to_company,

    -- outcome
    company_response,
    is_timely_response,
    company_response in (
        'Closed with monetary relief',
        'Closed with non-monetary relief'
    )                                        as is_relief

from complaints
