CREATE TABLE Board
    (
     ID INT,
     X INT NOT NULL,
     Y INT NOT NULL,
     Data VARCHAR(1) NULL
    );
    
INSERT INTO Board (x, y, Data) VALUES (2, 2, 'X');
INSERT INTO Board (x, y, Data) VALUES (2, 1, 'O');
INSERT INTO Board (x, y, Data) VALUES (1, 3, 'X');
INSERT INTO Board (x, y, Data) VALUES (3, 1, 'O');
INSERT INTO Board (x, y, Data) VALUES (1, 1, 'X');
INSERT INTO Board (x, y, Data) VALUES (1, 2, 'O');
INSERT INTO Board (x, y, Data) VALUES (3, 3, 'X');

select * from Board;

select x.num, y.nus from (select level as num from dual connect by level<=3 ) x,(select level as nus from dual connect by level<=3 ) y ;

select level as Y from dual connect by level<=3 

WITH sel as (select level as num from dual connect by level<=3)
, 
sel1 as (select sel.num as a, sel.num as b , sel.num as c , sel.num as d from sel )

select sel1.a as Y, sel1.b as "1", sel1.c as "2", sel1.d as "3" from sel1;

------------------------------------------------------------------------------
create table try_pivot as
WITH ap as (select level as num from dual connect by level<=3)
, 
empty_Board as (select t1.num as x, t2.num as y  from ap t1 CROSS JOIN ap t2)
,
Compare_Part as (select eb.x as x, eb.y as y, b.data as data from empty_Board eb LEFT OUTER JOIN Board b on (eb.x = b.x and eb.y = b.y))
select * from Compare_Part;

 /  
 select 
  y,
 MAX((DECODE(a.x, '1', data, null))) as "1",
 MAX((DECODE(a.x, '2', data, null)))  as "2",
 MAX((DECODE(a.x, '3', data, null)))  as "3"
from try_pivot a
group by y
 ORDER BY y
 
 
------------------------------------------------------------------------------ 
-- Solution with Pivot function
 WITH ap as (select level as num from dual connect by level<=3)
, 
empty_Board as (select t1.num as x, t2.num as y  from ap t1 CROSS JOIN ap t2)
,
Compare_Part as (select eb.x as x, eb.y as y, b.data as data from empty_Board eb LEFT OUTER JOIN Board b on (eb.x = b.x and eb.y = b.y))
select * from Compare_Part
pivot(MAX(data) for (x) in (1,2,3));

------------------------------------------------------------------------------ 