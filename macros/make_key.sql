{#
    Builds a readable text key from a column and its optional sub-column,
    for example: Credit card | Store credit card.
    A missing sub-column becomes "(none)" so the key is never NULL.
#}
{% macro make_key(column_name, sub_column_name) %}
    {{ column_name }} || ' | ' || coalesce({{ sub_column_name }}, '(none)')
{% endmacro %}