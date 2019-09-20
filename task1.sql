
CREATE TABLE Maan_Emp( 
    Emp_ID int NOT NULL, 
    Emp_Name varchar(100) NOT NULL, 
    Salary int NOT NULL, 
    Dept_ID int, 
    constraint PK_Maan_Emp PRIMARY KEY (Emp_ID), 
     
);

create table Maan_Dept 
( 
    Dept_ID int NOT NULL, 
    Dept_Name varchar(100) NOT NULL, 
    CONSTRAINT PK_Maan_Dept PRIMARY KEY (Dept_ID) 
);

INSERT INTO Maan_Dept (Dept_ID, Dept_Name) 
VALUES (202,'Manager');

INSERT INTO Maan_Dept (Dept_ID, Dept_Name) 
VALUES (303,'Account');

INSERT INTO Maan_Dept (Dept_ID, Dept_Name) 
VALUES (909,'Unknown');


INSERT INTO Maan_Emp (Emp_ID, Emp_Name, salary, dept_ID) 
VALUES ('1', 'Ahmet', 3000,'202');


INSERT INTO Maan_Emp (Emp_ID, Emp_Name, salary, dept_ID) 
VALUES ('3', 'Maan', 5000,'404');


INSERT INTO Maan_Emp (Emp_ID, Emp_Name, salary, dept_ID) 
VALUES ('2', 'Baraa', 4000,'303');

INSERT INTO Maan_Emp (Emp_ID, Emp_Name, salary) 
VALUES ('4', 'Samer', 5000);

INSERT INTO Maan_Emp (Emp_ID, Emp_Name, salary, dept_ID) 
VALUES ('6', 'Ali', 1000,'505');



-- Staj 1
-- SQL Task 1
UPDATE Maan_Emp 
SET Maan_Emp.Dept_ID = '909' 
WHERE NOT EXISTS (select Maan_Dept.Dept_ID from Maan_Dept where Maan_Emp.Dept_ID = Maan_Dept.Dept_ID);

UPDATE Maan_Emp 
SET Dept_ID = '909' 
WHERE Dept_ID NOT IN (select Maan_Dept.Dept_ID from Maan_Dept join Maan_Emp on Maan_Dept.Dept_ID = Maan_Emp.Dept_ID);

select Maan_Dept.Dept_ID from Maan_Dept union select Maan_Emp.Dept_ID from Maan_Emp;

-- Find The Dept which doesn't have any Employees
select * from Maan_Dept 
where not exists (select Dept_ID from Maan_Emp where Maan_Dept.Dept_ID = Maan_Emp.Dept_ID);

--------------------------------------------------------
-- The difference between EXISTS and IN 
-- NOT NULL = No Data Found (Unknown)
select * from Maan_Emp
where Exists (select Maan_Dept.Dept_ID   from Maan_Dept where Maan_Emp.Dept_ID = Maan_Dept.Dept_ID);

select * from Maan_Emp
where not Exists (select Dept_ID from Maan_Dept  where Maan_Emp.Dept_ID = Maan_Dept.Dept_ID 
                        UNION ALL
                        SELECT null from dual);

select * from Maan_Emp
where Dept_ID IN (select Dept_ID from Maan_Dept where Maan_Emp.Dept_ID = Maan_Dept.Dept_ID);

select * from Maan_Emp
where Dept_ID NOT IN (select Dept_ID from Maan_Dept where Maan_Emp.Dept_ID = Maan_Dept.Dept_ID);

--
UPDATE Maan_Emp 
SET Dept_ID = '909'
WHERE Dept_ID IS NOT NULL and  Dept_ID NOT IN 

         ( select Maan_Dept.Dept_ID   from Maan_Dept ); 
		 
select * from Maan_Emp 
WHERE   Dept_ID  NOT IN 

         (  202 , 303 , NULL);
         --select Maan_Dept.Dept_ID   from Maan_Dept

--------------------------------------------------------
-- The difference between INTERSECT and INNER JOIN
SELECT A_Table.id, B_Table.id FROM
A_Table INNER JOIN B_Table
ON A_Table.id = B_Table.id;

SELECT id FROM A_Table
INTERSECT
SELECT id FROM B_Table;

--------------------------------------------------------
-- using character manipulation functions
select employee_id, 
        CONCAT(first_name, last_name) NAME,
        job_id, 
        LENGTH(last_name),
        INSTR(last_name, 'a') "Contains 'a'?"
from hr.employees
where SUBSTR(job_id, 4) = 'REP';

-- Display the date of the next Friday that is six months from the hire date
select TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'FRIDAY'),'fmDay, Month ddth, YYYY')
        "Next 6 Months Review"
from hr.employees
ORDER BY hire_date;

--------------------------------------------------------
-- Date Functions
-- Number of work's weeks for evrey employee
select last_name , hire_date , (sysDate-hire_date)/7 as "Weeks of work" 
from hr.employees;

-- Using ROUND and TRUNC
select employee_id , hire_date , ROUND(hire_date,'MONTH'), TRUNC(hire_date,'MONTH')  
from hr.employees
where hire_date like '%04';

-------------------------------------------------------- 
-- General Functions
select last_name, salary, commission_pct,
        (salary*12)+(salary*12*commission_pct) AN_SAL
from hr.employees;

-- Using NVL(exp1, exp2)
select last_name, salary, commission_pct,
        (salary*12)+(salary*12*nvl(commission_pct,0)) AN_SAL
from hr.employees;

-- Using NVL2(exp1, exp2, expr3)
select last_name, salary, commission_pct,
        (salary*12)+(salary*12*nvl2(commission_pct,commission_pct,0)) AN_SAL
from hr.employees;

select last_name, salary, commission_pct,
       nvl2(commission_pct,'SAL+COM','SAL') Income
from hr.employees;

-- Using NULLIF(expr1, expr2)
select first_name, LENGTH(first_name) "expr1", 
        last_name, LENGTH(last_name) "expr2",
        NULLIF(LENGTH(first_name), LENGTH(last_name)) "result"
from hr.employees;

-- Using COALESCE(exp1,expr2,.......,exprn)
select last_name, employee_id, commission_pct, manager_id, 
        COALESCE(TO_CHAR(commission_pct), TO_CHAR(manager_id) , 'No commission No Mnager')
from hr.employees;

--------------------------------------------------------
-- Using Conditional Expressions
-- CASE Expression
select last_name, job_id, salary,
        CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                    WHEN 'PU_CLERK' THEN 1.15*salary
                    WHEN 'SA_MAN' THEN 1.12*salary
                    ELSE salary
        END "REVISED_SALARY"
from hr.employees;

select last_name, salary,
        CASE    WHEN salary<5000 THEN 'Low'
                WHEN salary<10000 THEN 'Medium'
                WHEN salary<20000 THEN 'Good'
                ELSE 'Excellent'
        END "Qualified_SALARY"
from hr.employees;

-- Using DECODE Function
select last_name, job_id, salary,
        DECODE (job_id, 'IT_PROG' , 1.10*salary,
                        'PU_CLERK', 1.15*salary,
                        'SA_MAN'  , 1.12*salary,
                         salary) "REVISED_SALARY"
from hr.employees;

-- Applicable TAX_RATE for every employee depending on the salary in department 80
select last_name, salary, TRUNC(salary/2000, 0) , 
        DECODE(TRUNC(salary/2000, 0) , 0 , 0.00,
                                       1 , 0.09,
                                       2 , 0.20,
                                       3 , 0.30,
                                       4 , 0.40,
                                       5 , 0.42,
                                       6 , 0.44,
                                           0.45) TAX_RATE
from hr.employees
where DEPARTMENT_ID = 80;

--------------------------------------------------------
-- Using group Function 
select ROUND(AVG(commission_pct),2)
from hr.employees;

select ROUND(AVG(NVL(commission_pct,0)),2)
from hr.employees;

--Using GROUP BY 
select department_id, job_id,  SUM(salary)
from hr.employees
where department_id > 40
group by department_id , job_id
order by department_id;

-- Using HAVING
select department_id, job_id,  MAX(salary)
from hr.employees
where department_id > 40
group by department_id , job_id
having  MAX(salary) > 10000
order by department_id;

--------------------------------------------------------
-- Using JOINS
select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id;

select  e.employee_id, 
        e.last_name, 
        l.city,
        e.department_id, 
        d.department_id, 
        d.department_name,
        d.location_id ,
        l.location_id 
from hr.employees e 
join hr.departments d
on  e.department_id = d.department_id
join hr.locations l
on  d.location_id = l.location_id;

-- SELF JOIN
select worker.last_name EMP , manager.last_name MGR
from hr.employees worker JOIN hr.employees manager
on worker.manager_id = manager.employee_id;

-- Nonequijions
select e.last_name , e.salary , j.grade_level
from hr.employees e JOIN hr.job_grades j
on e.salary
    between j.lowest_sal and j.highest_sal

-- Using OUTER JOIN
select e.last_name, e.department_id, d.department_id ,d.department_name
from hr.employees e left outer join hr.departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_id ,d.department_name
from hr.employees e right outer join hr.departments d
on e.department_id = d.department_id;

select last_name, department_name
from hr.employees
CROSS JOIN hr.departments;

--------------------------------------------------------
-- Using SUBQUERIES
select last_name, salary
from hr.employees
where salary > (select salary from hr.employees where last_name = 'Abel');

select last_name, job_id, salary
from hr.employees
where   job_id = (select job_id from hr.employees where last_name = 'Abel')
AND     salary > (select salary from hr.employees where last_name = 'Abel');

select last_name, job_id, salary
from hr.employees
where salary = (select min(salary) from hr.employees);

select department_id, MIN(salary)
from hr.employees
group by department_id
having MIN(salary) > (select MIN(salary) from hr.employees where department_id = 50);

-- Find the job with the lowest average salaryselect job_id, avg(salary)
from hr.employees
group by job_id
having avg(salary) = (select MIN(AVG(salary)) from hr.employees group by job_id);

select MIN(AVG(salary)) from hr.employees group by job_id;
--
select employee_id, last_name, job_id, salary
from hr.employees
where salary < ANY(select salary from hr.employees where job_id = 'IT_PROG')
AND   job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from hr.employees
where salary < ANY(select salary from hr.employees where job_id = 'IT_PROG')
AND   job_id <> 'IT_PROG';

--------------------------------------------------------
-- Some Exercises
select * from hr.employees;

select DISTINCT(JOB_ID) from hr.employees;

select last_name || ', ' || JOB_ID as "Employee and Title"
from hr.employees;

select last_name , HIRE_DATE
from hr.employees
where HIRE_DATE like '%06'

select last_name , salary
from hr.employees
where salary > &sal_amt;

select sysdate "Date"
from dual;

select employee_id, last_name, salary , salary + Round(salary * 15.5/100, 0) "New Salary"
from hr.employees;

select last_name, LPAD(salary, 15, '$') Salary
from hr.employees
order by Salary asc;

select RPAD(last_name,8) || ' ' || RPAD(' ', salary/1000, '*') "Employees and their Salaries"
from hr.employees
order by salary desc;

-- Important example 
-- Develop this with CASE function
select length(d), LPAD('X',length(d)-4,'X') || substr(d,length(d)-3,length(d))  from (
select '234' d from dual);

select length(d), LPAD('X',length(d)-(case when length(d) < 4 then 1 else 4 END),'X') || substr(d,length(d)-3,length(d))  from (
select '234' d from dual);
--------------------------------------------------------

