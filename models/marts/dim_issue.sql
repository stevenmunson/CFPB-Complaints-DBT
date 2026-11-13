select distinct
    issue || ' | ' || coalesce(sub_issue, '(none)')    as issue_key,
    issue,
    sub_issue
from {{ ref('int_complaints__products_remapped') }}