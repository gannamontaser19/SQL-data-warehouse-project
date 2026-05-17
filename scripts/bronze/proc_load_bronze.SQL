/*
===================================================================================
Stored Procedure: Load Bronze Layer(source-> Bronze)
===================================================================================
Script Purpose:
This stored procedure loads data into 'bronze' schema from external csv files.
It performs the following actions:
-Turncates the bronze tables before loading data
-Uses the 'Bulk Insert' command to load data from csv files to bronze tablea.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
	BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	
	BEGIN TRY
		PRINT '================================================';
		PRINT 'Loading Bronze Layer' ;
		PRINT '================================================';
	
		-------------------------------------------------------------------------------
		-- CRM TABLES
		-------------------------------------------------------------------------------
		PRINT '------------------------------------------------'; 
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		-- 1. bronze.crm_cust_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Data Analysis\SQL\DataWarehousing\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Sec';

		-- 2. bronze.crm_prd_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Data Analysis\SQL\DataWarehousing\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Sec';

		-- 3. bronze.crm_sales_details
		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Data Analysis\SQL\DataWarehousing\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Sec';

		-------------------------------------------------------------------------------
		-- ERP TABLES
		-------------------------------------------------------------------------------
		PRINT '------------------------------------------------'; 
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';

		-- 4. bronze.erp_cust_az12
		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Data Analysis\SQL\DataWarehousing\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Sec';

		-- 5. bronze.erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Data Analysis\SQL\DataWarehousing\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Sec';

		-- 6. bronze.erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Data Analysis\SQL\DataWarehousing\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Sec';

		PRINT '================================================';
		PRINT 'Bronze Layer Loaded Successfully!' ;
		PRINT '================================================';

	END TRY
	BEGIN CATCH
		PRINT '======================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number:  ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
		PRINT 'Error State:   ' + CAST(ERROR_STATE() AS NVARCHAR(10));
		PRINT '======================================='
	END CATCH
END;
