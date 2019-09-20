/*
Create the folowing table without using CREATE statement

REGION	COUNTRY
AMER	Argentina
EMEA	Belgium
AMER	Canada
ASIA	Japan
EMEA	Sweden
ASIA	Thailand

*/

with region_countries as (
   select 'AMER' as region, 'Argentina' as country from dual union all
   select 'EMEA', 'Belgium'   from dual union all
   select 'AMER', 'Canada'    from dual union all
   select 'ASIA', 'Japan'     from dual union all
   select 'EMEA', 'Sweden'    from dual union all
   select 'ASIA', 'Thailand'  from dual
) 
select * from region_countries