/*
Create Database and Schmeas
_ Script Puropse :
This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
within the database: 'bronze','silver','gold'.
*/

--Create Database 'DataWarehouse'
use master;
Go
-- Drop and recreate the 'DataWarehouse' database
IF exists(select 1 from sys.database where name='DataWarehouse')
Begin 
  Alter DATABASE DataWarehouse set single_user with ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

--create database DataWarehouse;
Create DATABASE DataWarehouse;
GO
use DataWarehouse;
GO 

--CREATE SCHEMAS
create schema bronze;
go
create schema silver;
go
create schema gold;
go



