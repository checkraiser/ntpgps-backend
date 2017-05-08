select user_id,check_in_month,check_in_day,check_in_time
from (
select a.user_id,date_part('day', a.created_at) check_in_day,date_part('month', a.created_at) check_in_month, date_part('hour', a.created_at) + round(CAST((date_part('minute', a.created_at)/60) as numeric),2) check_in_time
from check_ins a
left outer join check_outs b on a.user_id=b.user_id and date_trunc('day',a.created_at) =date_trunc('day',b.created_at)

) s