select
    company_name,
    min(date_received) as first_complaint_date,
    max(date_received) as latest_complaint_date
from {{ ref('int_complaints__products_remapped') }}
group by company_name
