TRUNCATE TABLE bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
from "C:\Users\ACER\OneDrive\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv"
with (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SELECT * FROM bronze.crm_cust_info;
SELECT COUNT(*) FROM bronze.crm_cust_info;


TRUNCATE TABLE bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
from "C:\Users\ACER\OneDrive\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv"
with (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SELECT * FROM bronze.crm_prd_info;
SELECT COUNT(*) FROM bronze.crm_prd_info;


TRUNCATE TABLE bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
from "C:\Users\ACER\OneDrive\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv"
with (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SELECT * FROM bronze.crm_sales_details;
SELECT COUNT(*) FROM bronze.crm_sales_details;



TRUNCATE TABLE bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
from "C:\Users\ACER\OneDrive\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv"
with (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SELECT * FROM bronze.erp_cust_az12;
SELECT COUNT(*) FROM bronze.erp_cust_az12;


TRUNCATE TABLE bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
from "C:\Users\ACER\OneDrive\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv"
with (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SELECT * FROM bronze.erp_loc_a101;
SELECT COUNT(*) FROM bronze.erp_loc_a101;



TRUNCATE TABLE bronze.erp_pk_cat_g1_v2
BULK INSERT bronze.erp_pk_cat_g1_v2
from "C:\Users\ACER\OneDrive\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv"
with (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SELECT * FROM bronze.erp_pk_cat_g1_v2;
SELECT COUNT(*) FROM bronze.erp_pk_cat_g1_v2;