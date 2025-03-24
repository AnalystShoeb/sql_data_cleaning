/*
==========================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==========================================================================================
Purpose of this script:
	This stored procedures load data into the 'bronze' schema from external CSV files.
	- Truncate the bronze tables before loading data.
	- Uses the BULK INSERT command to load data from csv Files to bronze tables.

Parameter: None.
	This stored procedure does not accept any parameter or retunn any values.

Usage Example:
	EXEC bronze.load_bronze

Remaining:
	Will put the timestamp to find out the total time needed to load the data.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		PRINT '=========================================================================='
		PRINT 'Loading Bronze Layer';
		PRINT '=========================================================================='

		PRINT '--------------------------------------------------------------------------'
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------------------------------'

		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Info: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Projects\03. sql_data_cleaning_project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Info: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Projects\03. sql_data_cleaning_project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Info: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Projects\03. sql_data_cleaning_project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '--------------------------------------------------------------------------'
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------------------------------------'

		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Info: bronze.erp_loc_a101s';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Projects\03. sql_data_cleaning_project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		PRINT '>> Truncating Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Info: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Projects\03. sql_data_cleaning_project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Info: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Projects\03. sql_data_cleaning_project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	END TRY
	BEGIN CATCH
		PRINT '=========================================================='
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================================='
	END CATCH
END
