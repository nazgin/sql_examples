-- 1 -- How many employees there are in the company --
SELECT COUNT(DISTINCT emp_id)
FROM EMPLOYEES


-- 2 -- How many employees there is per each rank -- 
SELECT 
	DISTINCT emp_rank as employee_rank
	, COUNT(emp_id)  OVER (PARTITION BY emp_rank) AS count_of_employee
FROM EMPLOYEES


-- 3 A -- What is the median salary per each department? --
-- https://leafo.net/guides/postgresql-calculating-percentile.html --

WITH t1 AS (
	SELECT
  		department_id
		, salary
	FROM Employees AS emp LEFT JOIN Salaries AS sal 
	ON emp.emp_id = sal.employee_id
)

SELECT 
	department_id
	, percentile_disc(0.5) within group (order by salary)
FROM t1
GROUP BY department_id


-- 3 B -- What is the median salary Per each site? --

WITH t2 AS (
  SELECT *
  FROM Employees AS emp LEFT JOIN Salaries AS sal 
  ON emp.emp_id = sal.employee_id
),

t3 AS (
  SELECT *
  FROM t2 Left JOIN department
  on t2.department_id = department.department_id
)

SELECT 
	site_id
	, percentile_disc(0.5) within group (order by salary)
FROM t3
GROUP BY site_id


-- 4 -- What is the most expensive site (cost + salaries) --

-- V.1 --
-- this solution will give us just sites where we have employees, 
-- sites without employees not included here. 
-- for better solution see V.2 of question 4.

WITH t2 AS (
  SELECT *
  FROM Employees AS emp LEFT JOIN Salaries AS sal 
  ON emp.emp_id = sal.employee_id
),

t3 AS (
  SELECT *
  FROM t2 Left JOIN department
  on t2.department_id = department.department_id
),

t4 AS (
  select 
  	DISTINCT t3.site_id
  	, sum(salary) over (PARTITION BY t3.site_id) AS sal_sum
  	, site_cost
  from t3 left join sites
  on t3.site_id = sites.site_id
)

SELECT 
	site_id
    , sal_sum
    , site_cost
    , COALESCE(sal_sum,0) + COALESCE(site_cost,0) AS "Total" -- need to use COALESCE in case we have null in site_cost or sal_sum 
FROM t4


-- V.2 --
-- This version of code will calculate total expences per site 
-- This code even will show sites with no salary payment per site.

with q3 AS (
  SELECT
  	DISTINCT department_id
    , sum(salary) over (PARTITION BY department_id) AS tot_sal_sum_per_dep
  FROM Employees AS emp LEFT JOIN Salaries AS sal 
  ON emp.emp_id = sal.employee_id
),

q4 as (
  SELECT
  	dep.site_id
  	, q3.tot_sal_sum_per_dep
  	, SUM(tot_sal_sum_per_dep) OVER (PARTITION BY dep.site_id) AS tot_sal_sum_per_site 
  from q3 LEFT JOIN department as dep
  on q3.department_id = dep.department_id
),

q5 AS (
  SELECT 
  	DISTINCT sites.site_id
  	, site_cost
  	, tot_sal_sum_per_site
  	, COALESCE(site_cost,0) + COALESCE(tot_sal_sum_per_site,0) AS total_per_site
  from sites full OUTER JOIN q4
  on sites.site_id = q4.site_id
)

SELECT
	site_id
    , site_cost
    , tot_sal_sum_per_site
    , total_per_site
	, RANK() OVER(ORDER BY total_per_site DESC) as rnk
FROM q5



-- 5 -- What is the biggest department? --

-- We can't calculate size of department. 
-- there is no data that indicate size of department. 
-- in our table we only have size of site 
-- we know in every site could be number of departments

-- If you wanted to know the biggest site by size? See below.
SELECT
	site_id
	, site_size as biggest_site_size
FROM sites
WHERE 
    site_size = 
    (
      SELECT MAX(site_size)
      FROM sites
    )


-- 6 -- What is the most expensive department? --










-- 7 -- How many employees joined in the last year? Split it by months --

with y1 as (
  SELECT
  	emp_id
  	, EXTRACT(YEAR from hiring_date) as hiring_year
	, EXTRACT(month from hiring_date) AS hiring_month
  	, EXTRACT(YEAR FROM CURRENT_DATE) as cur_year 
  FROM employees
)

Select
	hiring_year
    , hiring_month
    , COUNT(emp_id) OVER (PARTITION BY hiring_month) AS emp_joined
FROM y1
WHERE hiring_year = cur_year - 1


-- 8 -- What is the salary share of site #2 out of total salaries? --
-- in our case, with examples, let's assume that site #2 will be "12"

WITH t8 AS (
  SELECT *
  FROM Employees AS emp LEFT JOIN Salaries AS sal 
  ON emp.emp_id = sal.employee_id
),

t9 AS (
  SELECT *
  FROM t8 Left JOIN department
  on t8.department_id = department.department_id
),

t10 as (
  SELECT
  	site_id
  	, sum(salary) as total_salary_per_site
FROM t9
GROUP by site_id
order by site_id asc
),

t11 as (
  SELECT
	site_id
    , total_salary_per_site
    , SUM(total_salary_per_site) OVER() AS total_salary
    , total_salary_per_site / SUM(total_salary_per_site) OVER() AS perc_of_tot
from t10
)

select 
	site_id
    , perc_of_tot
from t11
WHERE site_id = '12'




-- 9 -- Plz create “churn” analysis by cohort of employees -- 






-- 10 -- Per each department, give the highest and lowest salary -- 
WITH q1 AS (
  SELECT *
  FROM Employees AS emp LEFT JOIN Salaries AS sal 
  ON emp.emp_id = sal.employee_id
)

SELECT 
	DISTINCT department_id
    , MAX (salary) as max_sal
    , min (salary) as min_sal
FROM q1
group by department_id
order by department_id ASC



