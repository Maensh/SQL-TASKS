CREATE TABLE Balls (
  id     NUMBER,
  name   varchar(20),
  color  varchar(20)
);

INSERT INTO Balls (id, name, color) VALUES (1, 'Liga', 'RED');
INSERT INTO Balls (id, name, color) VALUES (1, 'Liga', 'BLUE');
INSERT INTO Balls (id, name, color) VALUES (2, 'La-Liga', 'RED');
INSERT INTO Balls (id, name, color) VALUES (3, 'Super-Liga', 'RED');
INSERT INTO Balls (id, name, color) VALUES (4, 'UCL', 'BLUE');
INSERT INTO Balls (id, name, color) VALUES (5, 'PL', 'BLUE');
INSERT INTO Balls (id, name, color) VALUES (6, 'SA', 'WHITE');
INSERT INTO Balls (id, name, color) VALUES (7, 'Liga', 'BLUE');
INSERT INTO Balls (id, name, color) VALUES (8, 'Liga', 'RED');
INSERT INTO Balls (id, name, color) VALUES (9, 'UCL', 'RED');
INSERT INTO Balls (id, name, color) VALUES (10, 'SA', 'RED');
INSERT INTO Balls (id, name, color) VALUES (11, 'SA', 'BLUE');

select * from balls

-----------------------------------------------------------
-- How to add Grand Total as a row and a column
with GT_Table as
(
        SELECT name, RED_Balls, BLUE_Balls , WHITE_Balls, Grand_Total
        FROM   (SELECT  name, color,
                        sum(1) over (partition by name) as Grand_Total
        FROM   Balls)
        PIVOT  (count(1) as Balls FOR (color) IN ('RED' as RED, 'BLUE' as BLUE, 'WHITE' as WHITE))
)
select  nvl(name,'Grand_Total') as Name , 
        Sum(RED_Balls) as RED_Balls, 
        Sum(BLUE_Balls) as BLUE_Balls, 
        Sum(WHITE_Balls) as WHITE_Balls,
        Sum(Grand_Total) as Grand_Total
from GT_Table
group by grouping sets (name,())
