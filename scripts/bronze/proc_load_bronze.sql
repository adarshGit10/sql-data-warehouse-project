/*----------------------------------------------------------
sp for inserting csv file to table
truncate and load
-------------------------------------------------------
*/
	CREATE OR
	ALTER   PROCEDURE [bronze].[load_bronze] 
	AS BEGIN
	DECLARE @start_time DATETIME;
	DECLARE @end_time DATETIME;
	DECLARE @batch_starttime DATETIME;
	DECLARE @batch_endtime DATETIME;

	BEGIN TRY
	
		PRINT '============================================================================================================='
		PRINT 'BRONZE LAYER IS LOADING'
		PRINT '============================================================================================================='


		
			PRINT '============================================================================================================='
			PRINT 'LOADING CRM TABLES'
			PRINT '============================================================================================================='
			SET @batch_starttime= GETDATE();
			SET @start_time= getdate();
			PRINT'>> LOADING TABLE:[bronze].[crm_custom_info]';
		TRUNCATE TABLE [bronze].[crm_custom_info];
		BULK INSERT [bronze].[crm_custom_info]
		FROM 'C:\Users\adars\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @end_time= getdate();
		PRINT'>> DURATION TIME IS' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS'

----------------------------
SET @start_time= getdate();
		PRINT'>> LOADING TABLE:bronze.crm_sales_details';

		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\adars\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @end_time= getdate();
		PRINT'>> DURATION TIME IS' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS'
	--------------------
	SET @start_time= getdate();
	    PRINT'>> LOADING TABLE:bronze.crm_prod_info';
		TRUNCATE TABLE bronze.crm_prod_info;
		BULK INSERT bronze.crm_prod_info
		FROM 'C:\Users\adars\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @end_time= getdate();
		PRINT'>> DURATION TIME IS' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS'
		-----------------
			PRINT '=============================================================================================================';
			PRINT 'LOADING ERP TABLES';
			PRINT '=============================================================================================================';
		
		SET @start_time= getdate();
		PRINT'>> LOADING TABLE:bronze.erp_CUST_AZ12';

		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\adars\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @end_time= getdate();
		PRINT'>> DURATION TIME IS' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS'
		----------------
			SET @start_time= getdate();
		PRINT'>> LOADING TABLE:bronze.erp_LOC_A101';

			TRUNCATE TABLE bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\adars\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @end_time= getdate();
		PRINT'>> DURATION TIME IS' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS'

		----------------
		SET @start_time= getdate();
		PRINT'>> LOADING TABLE:bronze.erp_PX_CAT_G1V2'

			TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\adars\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
		)
		SET @end_time= getdate();
		PRINT'>> DURATION TIME IS' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS'
		SET @batch_endtime = getdate()

		PRINT '---------------------------------------------------------------------------------------'
		PRINT 'BATCH TOTAL TIME IS ' + CAST(DATEDIFF(SECOND,@batch_starttime,@batch_endtime) AS NVARCHAR) + 'SECONDS'
		PRINT '---------------------------------------------------------------------------------------'

		END TRY
		BEGIN CATCH
		PRINT '=================================================================================================================='
		PRINT 'ERROR OCCURED IN BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE' + CAST(ERROR_STATE() AS NVARCHAR);

		END CATCH
	END









