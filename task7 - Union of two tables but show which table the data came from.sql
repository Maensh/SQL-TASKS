create table Table_A (
   id    integer primary key
 , Type  varchar2(20)
 , Color varchar(20)
);

create table Table_B (
   id    integer primary key
 , Type  varchar2(20)
 , Color varchar(20)
);

insert into Table_A values(1,'Apple','Red');
insert into Table_B values(1,'Apple','Red');
insert into Table_A values(3,'Banana','Yellow');
insert into Table_A values(2,'Orange','Orange');
insert into Table_B values(2,'Orange','Orange');
insert into Table_B values(3,'Srawberry','pink');
insert into Table_B values(4,'Cheery','Red');
insert into Table_A values(4,'Limon','Yellow');

with U_Table as (select * from Table_A union all select * from Table_B)
select  case  when row_number() = 1 then 'Table_A' else 'Table_B' end 
from U_Table

-----------------------------------------------------------------------
select id,
       type, 
       color,
       case when rn = 1 then 'Table_A'
            else 'Table_B'
        end WhichTBL
from
(
   select Derived.*, rank() over (order by order_table) as rn from
   (
      select id,type,color, 'a' order_table from Table_A
      union all
      select id,type,color, 'b' order_table from Table_B
   ) Derived
)  
where rn >= 1
order by id,TYPE;

-------------------------------------------------------------------------
-- Simple Solution
select id,
       type, 
       color,
       case when rn = 'a' then 'Table_A'
            when rn = 'b' then 'Table_B'
        end WhichTBL from (
select id,type,color, 'a' rn from Table_A
      union all
      select id,type,color, 'b' rn from Table_B
);