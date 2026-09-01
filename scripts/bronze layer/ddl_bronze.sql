IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
DROP TABLE bronze.crm_cust_info;
create table bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gender NVARCHAR(50),
cst_create_date DATE
);



IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
DROP TABLE bronze.crm_prd_info;
create table bronze.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(5),
prd_start_dt DATETIME,
prd_end_dt DATETIME
)



IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
DROP TABLE bronze.crm_sales_details;
create table bronze.crm_sales_details (
sls_ord_num NVARCHAR(20),
sls_prd_key NVARCHAR(20),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
)




IF OBJECT_ID ('bronze.erp_CUST_AZ12', 'U') IS NOT NULL
DROP TABLE bronze.erp_CUST_AZ12;
create table bronze.erp_cust_az12 (
CID NVARCHAR(30),
BDATE DATE,
GEN NVARCHAR(15)
)




IF OBJECT_ID ('bronze.erp_LOC_A101', 'U') IS NOT NULL
DROP TABLE bronze.erp_LOC_A101;
create table bronze.erp_loc_a101 (
CID NVARCHAR(30),
CNTRY NVARCHAR(30)
)




IF OBJECT_ID ('bronze.erp_PK_CAT_G1_V2', 'U') IS NOT NULL
DROP TABLE bronze.erp_PK_CAT_G1_V2;
create table bronze.erp_pk_cat_g1_v2(
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
)
