select groups.id group_id, case when groups.name is null then 'No group' else groups.name end as group_name,users.id user_id,users.name,users.email,a.created_at check_in_created_at,a.address check_in_address,a.percentage check_in_percentage,b.created_at check_out_created_at,b.address check_out_address,b.percentage check_out_percentage,users.online_status
from check_ins a
left outer join user_groups on a.user_id=user_groups.user_id
left outer join groups on user_groups.group_id=groups.id
left outer join check_outs b on a.user_id=b.user_id and date_trunc('day',a.created_at)=date_trunc('day',b.created_at)
right outer join users on a.user_id=users.id
Where users.admin=false;