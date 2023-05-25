CREATE DATABASE Employee_Table;
USE Employee_Table;
USE employee;
CREATE TABLE Employee_Details
(
	Emp_ID INT,
    Full_Name VARCHAR(100),
    Manager_ID VARCHAR(50),
    Date_Of_Joining DATE,
    City VARCHAR(50)
);

CREATE TABLE Employee_Salary 
(
	Emp_ID INT,
    Project VARCHAR(50),
    Salary numeric(8,2),
    Variable VARCHAR(50)
);

DESCRIBE Employee_Details;
DESCRIBE Employee_Salary;
SELECT * FROM Employee_Details;
SELECT * FROM Employee_Salary;

-- SQL Query to fetch records that are present in one table but not in another table.

			SELECT * 
			FROM Employee_Details
			WHERE Emp_ID NOT IN 
            (
				SELECT Emp_ID 
				FROM Employee_Salary
            );

-- SQL query to fetch all the employees who are not working on any project.


			SELECT * 
            FROM Employee_Details
			WHERE Emp_ID NOT IN
            ( 
				SELECT Emp_ID 
				FROM Employee_Salary 
            );

-- SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

			SELECT * 
            FROM Employee_Details 
            WHERE Date_of_Joining LIKE  '__20%';
            
            -- Methode 2
            
			SELECT *
            FROM Employee_Details
            WHERE YEAR(Date_Of_Joining) = 2020;

-- Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

			SELECT * 
            FROM Employee_Details
            WHERE Emp_ID IN 
            ( 
				SELECT Emp_ID 
				FROM Employee_Salary
            );


-- Write an SQL query to fetch a project-wise count of employees.

			SELECT Project,COUNT(*) 
            FROM Employee_Salary
            GROUP BY Project;


-- Fetch employee names and salaries even if the salary value is not present for the employee.


			SELECT Employee_Details.Full_Name,
			COALESCE(Employee_Salary.Salary, 'N/A') AS Salary
			FROM Employee_Details
			LEFT JOIN Employee_Salary 
            ON Employee_Details.Emp_ID = Employee_Salary.Emp_ID;
    
    
-- Write an SQL query to fetch all the Employees who are also managers.

			SELECT * 
            FROM Employee_Details 
            WHERE Manager_ID ='Manager';

-- Write an SQL query to fetch duplicate records from EmployeeDetails.

			SELECT Emp_ID, COUNT(*)  AS Duplicate_Count
			FROM Employee_Details
			GROUP BY Emp_ID
			HAVING COUNT(*) > 1;

-- Write an SQL query to fetch only odd rows from the table.

			SELECT *
			FROM (
					SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
					FROM Employee_Details
				 ) AS T
			WHERE T.RowNum % 2 <> 0;
            
            
            

-- Write a query to find the 3rd highest salary from a table without top or limit keyword.

			SELECT Salary
			FROM Employee_Salary
			WHERE Salary < (
								SELECT MAX(Salary)
								FROM Employee_Salary
								WHERE Salary < (
													SELECT MAX(Salary)
													FROM Employee_Salary
												)
							)
			ORDER BY Salary DESC
			LIMIT 1;




    