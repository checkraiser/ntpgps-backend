select user_id,check_in_month,check_in_date,early
from (
select s1.user_id,date_part('month',s1.created_at) check_in_month, date_part('day',s1.check_in_date) check_in_date ,case when s1.check_in_time < 7.5 then round(cast(s1.check_out_time-7.5 as numeric),2) end as early
from (
Select a.user_id, a.created_at,a.created_at check_in_date, date_part('hour', a.created_at) + round(CAST((date_part('minute', a.created_at)/60) as numeric),2) check_in_time, date_part('hour', b.created_at) + round( CAST((date_part('minute', b.created_at)/60) as numeric),2) check_out_time        
from check_ins a 
left outer join check_outs b on a.user_id=b.user_id and date_trunc('day',a.created_at) =date_trunc('day',b.created_at)
) s1
) s