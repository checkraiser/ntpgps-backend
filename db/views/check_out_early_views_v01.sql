select user_id,check_out_month,check_out_date,early
from (
select s1.user_id,date_part('month',s1.created_at) check_out_month, date_part('day',s1.check_out_date) check_out_date ,case when s1.check_out_time < 16.5 then round(cast(16.5-s1.check_out_time as numeric),2) end as early
from (
Select b.user_id, b.created_at,b.created_at check_out_date, date_part('hour', b.created_at) + round(CAST((date_part('minute', b.created_at)/60) as numeric),2) check_out_time        
from check_outs a 
left outer join check_outs b on a.user_id=b.user_id and date_trunc('day',a.created_at) =date_trunc('day',b.created_at)
) s1
) s 