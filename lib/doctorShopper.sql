    
create table temp.opioid_users as 
select distinct pin
from pbs
JOIN pbs_item pi USING (pbs_code) 
WHERE pi.atc_code LIKE 'N02A%';
create index on temp.opioid_users(pin);

create table temp.attendance_items as
select item
  from mbs_rr JOIN mbs_desc_latest USING (item)
  where description like '%attendance%'
  group by 1
  order by count(*) desc
  limit 20
;
create index on temp.attendance_items(item);


create table temp.opioid_attendences as 
    select pin, date_of_service as spply_dt, spr
    from mbs 
    where item in ( select item from temp.attendance_items )
    AND
    pin in ( select pin from temp.opioid_users);


