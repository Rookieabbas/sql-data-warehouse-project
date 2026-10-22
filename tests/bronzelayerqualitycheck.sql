-----------------------------------------------------------------------------------------------------------------------------------------------------

--
-- ALL BRONZE LAYER QUALITY CHECK
--



--
--bronze.crm_cust_info
--

-- check for nulls or duplicates in primary key
select cst_id, COUNT(*) from bronze.crm_cust_info group by cst_id having COUNT(*)>1 or cst_id is null;

-- check for unwanted spaces
select cst_firstname from bronze.crm_cust_info where cst_firstname != TRIM(cst_firstname);
select cst_lastname from bronze.crm_cust_info where cst_lastname != TRIM(cst_lastname);
select cst_gender from bronze.crm_cust_info where cst_gender != TRIM(cst_gender);

-- data standarizaltion & consistency
select distinct cst_gender from bronze.crm_cust_info




--
--bronze.crm_prd_info
--


--check for primary key
select prd_id, count(*) from bronze.crm_prd_info group by prd_id having count(*) > 1 or prd_id is null;

--check for unwanted spaces
select prd_key from bronze.crm_prd_info where prd_key != trim(prd_key);

--check number quality
select prd_cost from bronze.crm_prd_info where prd_cost < 0 or prd_cost is null;

--data standarizasation and consistency
select distinct prd_line from bronze.crm_prd_info

--check  invalid date order
select * from bronze.crm_prd_info where prd_end_dt < prd_start_dt;


--
--bronze.crm_sales_details
--

--check for primary key
select sls_quantity, count(*) from bronze.crm_sales_details group by sls_quantity;

--check for invalid dates
select 
sls_order_dt from bronze.crm_sales_details
where sls_order_dt <=0 or len(sls_order_dt) <8;

select 
sls_order_dt from bronze.crm_sales_details where sls_order_dt > sls_due_dt or sls_order_dt > sls_ship_dt

select 
nullif(sls_order_dt,0) sls_order_dt from bronze.crm_sales_details;


--check for negtive values and data consistency
select sls_sales from bronze.crm_sales_details where sls_sales != sls_quantity * sls_price;
select sls_price from bronze.crm_sales_details where sls_price <=0;
select sls_sales from bronze.crm_sales_details where sls_sales <=0;




--
--bronze.erp_cust_az12
--

--primary key check
select CID, count(*) from bronze.erp_cust_az12 group by CID HAVING count(*) > 1 or CID is null; -- PRIMARY KEY CHECK

--GEN column consistency and integirty check
select GEN from bronze.erp_cust_az12 where GEN != TRIM(GEN); --GEN STANDARIZASTION CHECK
SELECT DISTINCT GEN FROM bronze.erp_cust_az12 

--looking for null dates
select BDATE from bronze.erp_cust_az12 where BDATE IS NULL --DATE CHECK




--
--bronze.erp_loc_a101;
--

--primarykey check
select CID, count(*) from bronze.erp_loc_a101 group by CID HAVING count(*) > 1 or CID is null; -- PRIMARY KEY CHECK

--cntry check
select distinct CNTRY from bronze.erp_loc_a101




--
--bronze.erp_pk_cat_g1_v2
--

--PRIMARY KEY CHECK
select ID, count(*) from bronze.erp_pk_cat_g1_v2 group by ID HAVING count(*) > 1 or ID is null; -- PRIMARY KEY CHECK


--checking unwanted spaces
select CAT, SUBCAT, MAINTENANCE FROM bronze.erp_pk_cat_g1_v2
where trim(CAT) != CAT OR TRIM(SUBCAT) != SUBCAT OR TRIM(MAINTENANCE) != MAINTENANCE

-- EXCELLENT DATA IN THIS TABLE NO ISSUE




-----------------------------------------------------------------------------------------------------------------------------------------------------