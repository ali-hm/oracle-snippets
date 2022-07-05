select ac.*,acc.*--owner,constraint_name,constraint_type,table_name,r_owner,r_constraint_name
from all_constraints ac
join ALL_CONS_COLUMNS acc on ac.constraint_name = acc.constraint_name
where ac.constraint_type='R' and ac.owner = upper(:owner) and acc.owner = upper(:owner)
and ac.r_constraint_name in (select constraint_name from all_constraints 
                              where constraint_type in ('P','U') and table_name=upper(:table_name));


