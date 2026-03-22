create database hr_analytics;
use hr_analytics;
create table employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    department VARCHAR(30),
    job_role VARCHAR(40),
    hire_date DATE,
    salary DECIMAL(10,2),
    performance_rating INT
);
CREATE TABLE attrition (
    employee_id INT,
    attrition VARCHAR(5),
    exit_date DATE,
    exit_reason VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    work_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
INSERT INTO employees VALUES
(101,'Amit Sharma','Male',28,'Sales','Sales Executive','2021-03-15',45000,3),
(102,'Neha Verma','Female',32,'HR','HR Manager','2019-07-10',65000,4),
(103,'Rahul Mehta','Male',26,'IT','Software Engineer','2022-01-20',55000,4),
(104,'Pooja Singh','Female',30,'Finance','Accountant','2020-09-05',60000,3),
(105,'Arjun Patel','Male',35,'Sales','Sales Manager','2018-11-12',80000,5),
(106,'Sneha Iyer','Female',27,'IT','Data Analyst','2022-06-01',58000,4),
(107,'Vikas Rao','Male',29,'Operations','Operations Executive','2021-04-18',42000,2),
(108,'Kavita Joshi','Female',31,'HR','HR Executive','2020-02-25',48000,3),
(109,'Rohit Kumar','Male',34,'Finance','Finance Manager','2017-08-30',90000,5),
(110,'Ananya Das','Female',25,'IT','Junior Developer','2023-01-10',40000,3);
INSERT INTO attrition VALUES
(101,'Yes','2023-08-15','Better Opportunity'),
(107,'Yes','2023-05-20','Low Salary'),
(110,'Yes','2023-10-01','Higher Studies'),
(102,'No',NULL,NULL),
(103,'No',NULL,NULL),
(104,'No',NULL,NULL),
(105,'No',NULL,NULL),
(106,'No',NULL,NULL),
(108,'No',NULL,NULL),
(109,'No',NULL,NULL);
INSERT INTO attendance VALUES
(1,101,'2023-07-01','Present'),
(2,101,'2023-07-02','Absent'),
(3,101,'2023-07-03','Absent'),
(4,102,'2023-07-01','Present'),
(5,102,'2023-07-02','Present'),
(6,103,'2023-07-01','Present'),
(7,103,'2023-07-02','Absent'),
(8,107,'2023-07-01','Absent'),
(9,107,'2023-07-02','Absent'),
(10,107,'2023-07-03','Absent'),
(11,110,'2023-07-01','Absent'),
(12,110,'2023-07-02','Absent'),
(13,110,'2023-07-03','Present'),
(14,105,'2023-07-01','Present'),
(15,106,'2023-07-01','Present');
SELECT * FROM employees;
SELECT * FROM attrition;
SELECT * FROM attendance;
-- total employees
select count(*) as total_emp from employees;

-- total emp in each department
select department,count(*) as emp_count_deptwise from employees
group by department;

-- attrition analysis
select attrition ,count(*) from attrition
group by attrition;

-- attrition rate
SELECT 
round(count(CASE WHEN attrition='Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM attrition;

-- salary analysis
-- average salary dept_wise
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
-- emp having salary above than average salary
SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Attrition by Department
SELECT e.department, a.attrition, COUNT(*) 
FROM employees e
JOIN attrition a ON e.employee_id = a.employee_id
GROUP BY e.department, a.attrition;

-- Absent employee analysis
SELECT e.employee_name, COUNT(*) AS absent_days
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Absent'
GROUP BY e.employee_name;





