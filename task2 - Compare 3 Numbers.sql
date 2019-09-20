select sum(Amount)
from (select CategoryID, sum(price) as Amount from Products group by CategoryID)

--------------------------------------------------------
-- Compare 3 Numbers
CREATE TABLE Pools( 
    Pool_ID int NOT NULL, 
    Pool_Name varchar(100) NOT NULL, 
    Pool_Length int NOT NULL, 
    Pool_Width int NOT NULL, 
    Pool_Depth int NOT NULL, 
    constraint PK_Pools PRIMARY KEY (Pool_ID)
);

-- Insert DATABASEINSERT INTO Pools (Pool_ID, Pool_Name, Pool_Length, Pool_Width, Pool_Depth) 
VALUES (4, 'A', 54, 234, 6);

INSERT INTO Pools (Pool_ID, Pool_Name, Pool_Length, Pool_Width, Pool_Depth) 
VALUES (5, 'B', 6, 45, 334);

INSERT INTO Pools (Pool_ID, Pool_Name, Pool_Length, Pool_Width, Pool_Depth) 
VALUES (6, 'C', 56, 40, 20);

-- Solution 1
SELECT  Pool_Name, 
        GREATEST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) Greatest , 
        LEAST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) LEAST ,
        (POOL_LENGTH + POOL_WIDTH + POOL_DEPTH - GREATEST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) - LEAST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH)) Middle
from Pools;

-- Solution 2
SELECT  Pool_Name, 
        GREATEST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) Greatest , 
        LEAST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) LEAST ,
        
        case when ((POOL_LENGTH > POOL_WIDTH) and (POOL_DEPTH < POOL_WIDTH)) 
                or ((POOL_LENGTH < POOL_WIDTH) and (POOL_DEPTH > POOL_WIDTH)) 
                then POOL_WIDTH
                
             when (POOL_LENGTH > POOL_WIDTH) and (POOL_DEPTH > POOL_WIDTH) and (POOL_LENGTH > POOL_DEPTH) 
                or ((POOL_LENGTH < POOL_WIDTH) and (POOL_DEPTH < POOL_WIDTH) and (POOL_LENGTH < POOL_DEPTH))
                then POOL_DEPTH
                
             when (POOL_LENGTH > POOL_WIDTH) and (POOL_DEPTH > POOL_WIDTH) and (POOL_LENGTH < POOL_DEPTH)
                or ((POOL_LENGTH < POOL_WIDTH) and (POOL_DEPTH < POOL_WIDTH) and (POOL_LENGTH > POOL_DEPTH))
                then POOL_LENGTH
             
             else 0
        END Middle
from Pools;

-- Solution 3
SELECT  Pool_Name, 
        GREATEST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) Greatest , 
        LEAST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) LEAST ,
        case GREATEST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) 
            when POOL_LENGTH then  GREATEST( POOL_WIDTH, POOL_DEPTH) 
            when POOL_WIDTH then  GREATEST( POOL_LENGTH, POOL_DEPTH) 
            when POOL_DEPTH then  GREATEST( POOL_LENGTH, POOL_WIDTH) 
        END Middle
from Pools;    
        
-- Solution 4
SELECT  Pool_Name, 
        GREATEST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) Greatest , 
        LEAST(POOL_LENGTH, POOL_WIDTH, POOL_DEPTH) LEAST ,
        LEAST( GREATEST(POOL_LENGTH, POOL_WIDTH),
               GREATEST(POOL_LENGTH, POOL_DEPTH),
               GREATEST(POOL_WIDTH, POOL_DEPTH) ) Middle
from Pools;