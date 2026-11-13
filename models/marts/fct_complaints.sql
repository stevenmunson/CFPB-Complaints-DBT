with complaints as (

    select * from {{ ref('int_complaints__products_remapped') }}

)

select
    -- keys
    complaint_id,
    product || ' | ' || coalesce(sub_product, '(none)')   as product_key,
    issue || ' | ' || coalesce(sub_issue, '(none)')       as issue_key,
    company_name,
    state_code,
    submitted_via,

    -- dates
    date_received,
    date_sent_to_company,
    date_sent_to_company - date_received                  as days_to_send_to_company,

    -- outcome
    company_response,
    is_timely_response,
    company_response in (
        'Closed with monetary relief',
        'Closed with non-monetary relief'
    )                                                     as is_relief

from complaints