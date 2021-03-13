-- Creating EMPLOYEES table --  
CREATE TABLE EMPLOYEES (
  emp_id int NOT NULL PRIMARY KEY
  , emp_name VARCHAR(255) NOT NULL
  , emp_rank INT NOT NULL
  , department_id INT not NULL
  , hiring_date DATE not NULL
  , still_working BOOLEAN Not NULL
);

-- Inserting data to EMPLOYEES table --
INSERT INTO EMPLOYEES
    (emp_id, emp_name, emp_rank, department_id, hiring_date, still_working)
VALUES 
    (1, 'George Washington', 1, 999, '2020-01-12', TRUE)
	, (2, 'Thomas Jefferson', 2, 888, '2011-11-11', TRUE)
	, (3, 'John Adams', 1, 666, '2020-04-11', TRUE)
	, (4, 'Thomas Anderson', 3, 777, '2018-07-10', TRUE)
	, (5, 'James Elephant', 2, 888, '2002-11-05', FALSE)
	, (6, 'Bob Baobab', 2, 111, '2020-11-05', FALSE)
	, (7, 'Will Johnliams', 1, 999, '2002-01-17', TRUE)
	, (8, 'Yankeele Pinankele', 2, 333, '2020-03-05', TRUE)
	, (9, 'Bobale Shnobale', 3, 555, '2017-01-01', TRUE);
    

-- Creating DEPARTMENT table --  
CREATE TABLE DEPARTMENT (
  department_id int NOT NULL PRIMARY KEY
  , department_name VARCHAR(255) NOT NULL
  , department_manager_id INT NOT NULL
  , site_id INT not NULL
);

-- Inserting data to DEPARTMENT table --
INSERT INTO DEPARTMENT
    (department_id, department_name, department_manager_id, site_id)
VALUES 
    (999, 'Triple nine', 99, 11)
	, (888, 'Three time eight', 88, 11)
	, (777, 'Bingo', 77, 16)
	, (666, 'Hell no', 66, 12)
    , (555, 'Friday dep', 55, 10)
	, (444, 'Three times four', 44, 13)
	, (333, 'Triple three', 44, 14)
	, (222, 'Double sandwich', 44, 15)
	, (111, 'One one one', 44, 15)
	, (101, 'The first one', 44, 12);
    

-- Creating SALARIES table --  
CREATE TABLE SALARIES (
  employee_id int NOT NULL PRIMARY KEY
  , salary int NOT NULL
  , bank_account INT NOT NULL
);
    
-- Inserting data to SALARIES table --
INSERT INTO SALARIES
    (employee_id, salary, bank_account)
VALUES 
    (1, 100, 11111)
	, (2, 300, 22222)
	, (3, 340, 44444)
	, (4, 330, 33333)
   	, (5, 500, 66666)
   	, (6, 600, 55555)
   	, (7, 450, 77777)
   	, (8, 660, 88888)  
   	, (9, 570, 55555);    
    
-- Creating SITES table --  
CREATE TABLE SITES (
  site_id int NOT NULL PRIMARY KEY
  , site_size int NOT NULL
  , site_cost INT NOT NULL
);
    
-- Inserting data to SITES table --
INSERT INTO SITES
    (site_id, site_size, site_cost)
VALUES 
    (10, 1002, 78899)
	, (11, 2333, 50000)
	, (12, 3445, 45666)
	, (13, 6645, 5666)
	, (14, 9445, 4066)
	, (15, 3400, 45966)
	, (16, 3498, 25666);
