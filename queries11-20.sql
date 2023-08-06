use AdventureWorks2022

/*
11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.
*/


--First, I write a query statement to list all tables related to 'person'
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_SCHEMA like 'person'
    AND TABLE_NAME like '%person%';

--Next, I modify the query above to retrieve table infomation with columns name 'last name' keyword from all tables related to 'person'.

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA like 'person'
    AND TABLE_NAME like '%person%'
    AND COLUMN_NAME like '%last%name';


SELECT
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'Person';

-- However, I realized that the query result returned 2 tables. Therefore, I reviewed the requirement and discovered that the data to be collected is related to 'BusinessEntityID','PhoneNumber' field. From there, I enhanced my query statement by adding a condition that column must contain keyword 'BusinessEntityID','PhoneNumber'.

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_SCHEMA like '%person%'
    AND TABLE_NAME like '%person%'
    AND (COLUMN_NAME like '%last%name%' 
        OR COLUMN_NAME like '%Business%Entity%' 
        OR COLUMN_NAME like '%Phone%')
ORDER BY
    TABLE_SCHEMA ASC,
    TABLE_NAME  ASC


--Return BusinessEntityID, FirstName, PhoneNumber and last name with it starts with letter 'L'. Sort the result on lastname and firstname.
SELECT
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    pPh.PhoneNumber
FROM
    Person.Person AS p
    INNER JOIN Person.PersonPhone AS pPh ON p.BusinessEntityID = pPh.BusinessEntityID
WHERE
    p.LastName like 'L%'
ORDER BY
    P.LastName ASC,
    P.FirstName ASC;


SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    COLUMN_NAME like '%Name%'



SELECT 
    E.LoginID,
    P.FirstName,
    D.Name AS Department,
    E.JobTitle
FROM 
    HumanResources.Employee AS E
    INNER JOIN HumanResources.EmployeeDepartmentHistory AS EDH 
            ON E.BusinessEntityID = EDH.BusinessEntityID
    INNER JOIN HumanResources.Department AS D 
            ON EDH.DepartmentID = D.DepartmentID
    INNER JOIN Person.Person AS P
            ON E.BusinessEntityID = P.BusinessEntityID 




