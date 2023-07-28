use AdventureWorks2022

EXEC sp_spaceused; --Check database size

--Show all table
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA LIKE 'Human%R%'


/*
1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.
*/

SELECT *
FROM 
    HumanResources.Employee emp
ORDER BY 
    emp.JobTitle ASC;

/*
2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname.
*/

SELECT *
FROM
    Person.Person psn
ORDER BY
    psn.LastName ASC;

/*
3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.
*/

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Person';


SELECT 
    psn.FirstName,
    psn.LastName,
    psn.businessentityid as Employee_id
FROM 
    Person.Person as psn
ORDER BY
    lastname ASC;


/*
4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.
*/

-- To solve the given context. Write a query to find correct table to queried 
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA like 'Product%' 
    AND COLUMN_NAME like '%product%line%';



SELECT
    prd.productid,
    prd.productnumber,
    prd.name
FROM 
    Production.Product AS prd
WHERE 
    prd.sellstartdate IS NOT NULL
    AND prd.productline NOT LIKE 'T%'
ORDER BY
    name ASC;

/*
5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.
*/

--To solve this issue. 
--Write to a query to find correct table and queried.
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM 
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_NAME like '%salesorderheader%';

--Write to a query to retrieving columns name from salesorderheader table. From there, I will find correct the columns name and queried.
SELECT
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'SalesOrderHeader';

--Result
SELECT
    sOH.salesorderid, 
    sOH.customerid,
    sOH.orderdate,
    sOH.subtotal,
    (sOH.TaxAmt*100)/sOH.SubTotal as percentageoftaxcolumn
FROM
    Sales.salesorderheader as sOH
ORDER BY
    sOH.SubTotal asc;

/*
6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.
*/

--Write to a query to find correct the table.
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_NAME like '%employee%';

--Write to a query to find correct the column name in Employee table.
SELECT
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'Employee';

--Result
SELECT DISTINCT
    emp.jobtitle
FROM
    HumanResources.employee as emp;

/*
7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.
*/
--Write to a query statement to find correct the table in database.
/*
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_NAME like '%sales%'
*/

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    COLUMN_NAME like '%freight%'

--Write to a query statement 
SELECT
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'SalesOrderHeader';


--Result
SELECT
    sOH.customerid,
    sum(sOH.freight) as totalfreight
FROM
    Sales.salesorderheader as sOH
GROUP BY
    sOH.customerid
ORDER BY
    sOH.customerid ASC;


/*
8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
*/
--Write a query statement to find correct the table.
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    COLUMN_NAME like 'subtotal';


SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME like 'SalesOrderHeader';

--Result
SELECT
    sOH.customerid,
    sOH.salespersonid,
    AVG(sOH.SubTotal) as theaverageofsubtotal,
    SUM(sOH.SubTotal) as thesumofthesub
FROM
   Sales.SalesOrderHeader as sOH
GROUP BY
    sOH.customerid,
    sOH.salespersonid
ORDER BY
    sOH.CustomerID DESC;

/*
9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order.
*/

--
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_NAME like '%product%';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    COLUMN_NAME like '%productid%'
    OR COLUMN_NAME like '%quantity%'
    OR COLUMN_NAME like '%shelf%';


SELECT
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME like '%ProductInventory%'

--
SELECT
    pPI.ProductID,
    SUM(pPI.Quantity) as sumquantity
FROM
    Production.ProductInventory AS pPI
WHERE
    pPI.Quantity > 500
    AND pPI.Shelf in ('A','C','H')
GROUP BY
    pPI.ProductID
HAVING
     SUM(pPI.Quantity) > 500;


/*
10. From the following table write a query in SQL to find the total quantity for a group of locationid multiplied by 10.
*/

--
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    COLUMN_NAME like '%quantity%'
    OR COLUMN_NAME like '%locationid%';

SELECT top 1 *
FROM
    Production.ProductInventory AS pL
;

--Result
SELECT
    SUM(pL.Quantity) AS sumquantity
FROM
    Production.ProductInventory AS pL
GROUP BY
    (pl.LocationID*10)
ORDER BY
    sumquantity ASC;