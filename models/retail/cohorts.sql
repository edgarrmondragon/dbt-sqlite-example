select
  cohort_month
  {%- for i in range(15) %}
  , round(sum(case when cohort_index = {{ i }} then amount else 0 end), 2) as index_{{i}}
  {%- endfor %}
  , sum(amount) as overall
from {{ ref('orders') }}
group by cohort_month
