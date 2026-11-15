select distinct
    {{ make_key('issue', 'sub_issue') }} as issue_key,
    issue,
    sub_issue
from {{ ref('int_complaints__products_remapped') }}
