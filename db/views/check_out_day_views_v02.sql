select user_id,check_out_month,check_out_day,check_out_time
from (
select b.user_id,date_part('month', b.created_at) check_out_month,date_part('day', b.created_at) check_out_day, date_part('hour', b.created_at) + round(CAST((date_part('minute', b.created_at)/60) as numeric),2) check_out_time
from check_ins a
left outer join check_outs b on a.user_id=b.user_id and date_trunc('day',a.created_at) =date_trunc('day',b.created_at)
--Where date_part('month', a.created_at)=5
) s