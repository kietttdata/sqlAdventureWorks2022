use AdventureWorks2022

-- Exploring all tables of sales schema
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM
    INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_SCHEMA like '%Sale%';


--Exploring all constraint name of sales schema
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    column_name,
    constraint_name
FROM 
    information_schema.key_column_usage
WHERE 
    table_schema like '%Sale%'
    AND Constraint_Name like '%PK%';







