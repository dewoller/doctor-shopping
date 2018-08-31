drop table if exists mbs_apnea;
create table mbs_apnea as
select pin, item, date_of_service, sex, yob
from mbs JOIN patient using (pin)
where item in ( '09067','12203','12206','12209','12212','12250');


limit 100;

select item, count(*) from mbs_apnea group by 1;


create table mbs_apnea_unique as 
select pin, sex, yob, min(item) as item, min(date_of_service) as first_service, max(date_of_service) as last_service,
max(date_of_service) - min(date_of_service) as ndays, count(*) as ntests
from mbs_apnea
group by 1,2,3 ;

alter table mbs_apnea_unique  add (nservices integer );

update mbs_apnea_unique u set nservices = (select count(*) from mbs where mbs.pin=u.pin);

create table mbs_apnea_yob_sex as select distinct yob, sex from mbs_apnea;

create table mbs_apnea_matched_sample as 
select pin, sex, yob, count(*) as ntests
from mbs JOIN patient p USING (pin)
join mbs_apnea_yob_sex using (sex, yob )
group by 1,2,3 ;

select pin, spply_dt, pbs_code, 
atc_code, 
pbs_rgltn24_adjst_qty as quantity
from pbs_rr JOIN pbs_item using (pbs_code)
where atc_code like 'N02%' limit 100; 




Copy (Select * From temp.n02a) To '/tmp/n02a.csv' With CSV DELIMITER ',' HEADER;

copy (select * from patient where pin in (select pin from temp.n02a)) To '/tmp/n02a_pp.csv' With CSV DELIMITER ',' HEADER;
