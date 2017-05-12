select s1.group_id,case when s1.group_name is null then 'No group' else s1.group_name end as group_name ,users.id user_id,users.name,s1.check_in_created_at,s1.check_in_address,s1.check_in_latitude,s1.check_in_longitude
,s1.check_in_percentage,s2.check_out_created_at,s2.check_out_address,s2.check_out_latitude,s2.check_out_longitude
,s2.check_out_percentage,users.online_status
from (
select groups.id group_id,groups.name group_name,a.user_id,a.created_at check_in_created_at,b.address check_in_address,b.latitude check_in_latitude,b.longitude check_in_longitude,b.percentage check_in_percentage
from check_ins a
inner join locations b on a.user_id=b.user_id and a.created_at=b.created_at
inner join user_groups on a.user_id=user_groups.user_id
inner join groups on user_groups.group_id=groups.id
) as s1
 left outer join (
select a.user_id,a.created_at check_out_created_at,b.address check_out_address,b.latitude check_out_latitude,b.longitude check_out_longitude,b.percentage check_out_percentage
from check_outs a
inner join locations b on a.user_id=b.user_id and a.created_at=b.created_at
) as s2 on s1.user_id=s2.user_id and date_trunc('day',s1.check_in_created_at)=date_trunc('day',s2.check_out_created_at)
right outer join users on s1.user_id=users.id 
Where users.admin=false;