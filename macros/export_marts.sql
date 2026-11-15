{% macro export_marts(folder='C:/dbt/exports') %}
    {% set marts = ['fct_complaints', 'dim_product', 'dim_issue', 'dim_company', 'dim_state', 'dim_date'] %}
    {% for mart in marts %}
        {% set sql %}
            copy (select * from {{ ref(mart) }}) to '{{ folder }}/{{ mart }}.parquet' (format parquet)
        {% endset %}
        {% do run_query(sql) %}
        {% do log('Exported ' ~ mart ~ ' to ' ~ folder, info=True) %}
    {% endfor %}
{% endmacro %}