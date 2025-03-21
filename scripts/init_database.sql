/*
==========================================
Create Database and Schemas
==========================================
Script Purpose:
	This script create a new database names 'DataWarehouse' after checking if if already exists.
	If the database exists, it is dropped and recreated. Additionally, the set up three schemas
	within the datase: 'bronze', 'silver', and 'gold'.

Warning:
	Running this script will drop the entire 'DataWarehouse' database if it exists.All data in the 
	database will be permanently deleted. Proceed with caution and ensure you have proper backups 
	before running this scripts. 
*/


-- Switch to the master database
USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
-- Check if the 'DataWarehouse' database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	-- Force the database into SINGLE_USER mode to drop it safely
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;	
	-- Drop the existing database
	DROP DATABASE DataWarehouse;
END;
GO

-- Create a new 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

-- Switch to the newly created 'DataWarehouse' database
USE DataWarehouse;
GO

-- Create schemas to organize data processing stages

-- 'bronze' schema for raw, unprocessed data
CREATE SCHEMA bronze;
GO

-- 'silver' schema for cleaned and transformed data
CREATE SCHEMA silver;
GO

-- 'gold' schema for aggregated and optimized data for reporting
CREATE SCHEMA gold;
GO
