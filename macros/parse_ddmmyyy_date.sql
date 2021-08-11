{%- macro parse_ddmmyyyy_date(value) -%}

substr({{ value }}, 7)
|| '-'
|| substr({{ value }}, 4, 2)
|| '-'
|| substr({{ value }}, 1, 2)

{%- endmacro -%}
