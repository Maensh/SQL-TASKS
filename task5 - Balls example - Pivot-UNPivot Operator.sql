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


create table Pivot_Balls as
(
SELECT *
FROM   (SELECT  name, color
        FROM   Balls)
PIVOT  (count(1) as quantity FOR (color) IN ('RED' as RED, 'BLUE' as BLUE, 'WHITE' as WHITE))
)

-----------------------------------------------------------
select * from Pivot_Balls
unpivot(quantity for color IN (RED_QUANTITY as 'RED', BLUE_QUANTITY as 'BLUE', WHITE_QUANTITY as 'WHITE'))
where quantity != 0