select * 
from pbs_item 
where atc = "N07BC";


select * 
from pbs_item 
where atc = "N07BC";


with bupre as (
select * 
from pbs_item 
where atc_code like 'N07BC%'
)
, drugs as (
	select * 
	FROM pbs p JOIN bupre b using (pbs_code)
) select * from drugs
;

