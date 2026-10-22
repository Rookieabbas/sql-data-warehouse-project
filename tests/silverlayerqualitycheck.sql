-----------------------------------------------------------------------------------------------------------------------------------------------------

--
-- ALL SILVER LAYER QUALITY CHECK
--



--
--crm_cust_info
--

-- check for nulls or duplicates in primary key
select cst_id, COUNT(*) from silver.crm_cust_info group by cst_id having COUNT(*)>1 or cst_id is null;
select * from silver.crm_cust_info;

-- check for unwanted spaces
select cst_firstname from silver.crm_cust_info where cst_firstname != TRIM(cst_firstname);
select cst_lastname from silver.crm_cust_info where cst_lastname != TRIM(cst_lastname);
select cst_gender from silver.crm_cust_info where cst_gender != TRIM(cst_gender);

-- data standarizaltion & consistency
select distinct cst_gender from silver.crm_cust_info




--
--crm_prd_info quality check
--

--check for primary key
select prd_id, count(*) from silver.crm_prd_info group by prd_id having count(*) > 1 or prd_id is null;

--check for unwanted spaces
select prd_key from silver.crm_prd_info where prd_key != trim(prd_key);

--check number quality
select prd_cost from silver.crm_prd_info where prd_cost < 0 or prd_cost is null;

--data standarizasation and consistency
select distinct prd_line from silver.crm_prd_info

--check  invalid date order
select * from silver.crm_prd_info where prd_end_dt < prd_start_dt;



--
--crm_sales_details quality check
--

--check for invalid dates
select 
sls_order_dt from silver.crm_sales_details where sls_order_dt > sls_due_dt or sls_order_dt > sls_ship_dt


--check for negtive values and data consistency
select sls_sales from silver.crm_sales_details where sls_sales != sls_quantity * sls_price;
select sls_price from silver.crm_sales_details where sls_price <=0;
select sls_sales from silver.crm_sales_details where sls_sales <=0;




--
--silver.erp_cust_az12
--

--primary key check
select CID, count(*) from silver.erp_cust_az12 group by CID HAVING count(*) > 1 or CID is null; -- PRIMARY KEY CHECK

--GEN column consistency and integirty check
select GEN from silver.erp_cust_az12 where GEN != TRIM(GEN); --GEN STANDARIZASTION CHECK
SELECT DISTINCT GEN FROM silver.erp_cust_az12 


--
--silver.erp_loc_a101;
--

--primarykey check
select CID, count(*) from silver.erp_loc_a101 group by CID HAVING count(*) > 1 or CID is null; -- PRIMARY KEY CHECK

--cntry check
select distinct CNTRY from silver.erp_loc_a101




-----------------------------------------------------------------------------------------------------------------------------------------------------