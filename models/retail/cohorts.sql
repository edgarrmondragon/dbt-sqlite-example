select
  cohort_month
  {% for i in range(15) -%}
  , cast(
    round(sum(case when cohort_index = {{ i }} then amount else 0 end), 2) as real
  ) as index_{{ i }}
  {% endfor -%}
  , cast(sum(amount) as real) as overall
from {{ ref('orders') }}
group by cohort_month
