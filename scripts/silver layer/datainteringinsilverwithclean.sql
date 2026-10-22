-----------------------------------------------------------------------------------------------------------------------------------------------------


--
-- INSERTION OF CLEANED DATA INTO ALL THE SILVER LAYER
--




--
--insertion of silver.crm_cust_info
--

insert into silver.crm_cust_info(
cst_id, cst_key, cst_firstname, cst_lastname, cst_material_status, cst_gender, cst_create_date )   
select 
cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
case when UPPER(TRIM(cst_material_status)) = 'S' then 'SINGLE'
     when UPPER(TRIM(cst_material_status)) = 'M' then 'MARRIED'
     else 'unknown'
END cst_material_status,
case when UPPER(TRIM(cst_gender)) = 'F' then 'FEMALE'
     when UPPER(TRIM(cst_gender)) = 'M' then 'MALE'
     else 'unknown'
END cst_gender,
cst_create_date
from  (
select *, ROW_NUMBER() OVER(PARTITION BY cst_id order by cst_create_date DESC) AS flag_last 
from bronze.crm_cust_info
)t where flag_last = 1;

delete from silver.crm_cust_info where cst_id is null;


select * from silver.crm_cust_info;




--
--insertion of silver.crm_prd_info
--

insert into silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
select 
prd_id,
replace(SUBSTRING (prd_key,1, 5), '-', '_') as cat_id,
SUBSTRING(prd_key,7, LEN(prd_key)) as prd_key,
prd_nm,
isnull(prd_cost, 0) as prd_cost,

case
when upper(trim(prd_line)) = 'M' then 'Mountain'
when upper(trim(prd_line)) = 'R' then 'Road'
when upper(trim(prd_line)) = 'S' then 'other sales'
when upper(trim(prd_line)) = 'T' then 'Touring'
else 'n/a'
end as prd_line,

cast(prd_start_dt as date) as prd_start_dt,
cast(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt)-1 as date) as prd_end_dt 
from bronze.crm_prd_info;


select * from silver.crm_prd_info;





--
--insertion in silver.crm_sales_details
--

insert into silver.crm_sales_details(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)

select
sls_ord_num,
sls_prd_key,
sls_cust_id,
case
when sls_order_dt = 0 or len(sls_order_dt) != 8 then null
else cast(cast(sls_order_dt as varchar) as date)
end as sls_order_dt,

case
when sls_ship_dt = 0 or len(sls_ship_dt) != 8 then null
else cast(cast(sls_ship_dt as varchar) as date)
end as sls_ship_dt,

case
when sls_due_dt = 0 or len(sls_due_dt) != 8 then null
else cast(cast(sls_due_dt as varchar) as date)
end as
sls_due_dt,

case
when sls_sales <= 0 or sls_sales is null then abs(sls_quantity * sls_price)
when sls_sales != sls_quantity * sls_price then abs(sls_quantity * sls_price )
else sls_sales
end as sls_sales,

sls_quantity,


case 
when sls_price = 0 or sls_price is null then abs(sls_sales / nullif(sls_quantity,0))
when sls_price < 0  then ABS(sls_price)
else sls_price
end as sls_price

from bronze.crm_sales_details;

select * from silver.crm_sales_details;




--
--insertion in silver.erp_cust_az12
--

insert into silver.erp_cust_az12(
CID,
BDATE,
GEN
)

SELECT

case 
when CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
end AS CID,

case 
when BDATE > GETDATE() THEN NULL
ELSE BDATE
END AS BDATE,
case when UPPER(TRIM(GEN)) = 'F' then 'FEMALE'
     when UPPER(TRIM(GEN)) = 'M' then 'MALE'
     when UPPER(TRIM(GEN)) = 'Female' then 'FEMALE'
     when UPPER(TRIM(GEN)) = 'Male' then 'FEMALE'
     else 'unknown'
END GEN
FROM bronze.erp_cust_az12;

select * from silver.erp_cust_az12




--
--insertion into silver.erp_loc_a101
--

insert into silver.erp_loc_a101(
CID,
CNTRY)

select
REPLACE(CID, '-', '') AS CID,
case
when TRIM(CNTRY) = '' or CNTRY IS NULL  THEN 'n/a'
when TRIM(CNTRY) = 'DE' then 'Germany'
when TRIM(CNTRY) IN ('US','USA') THEN 'United States'
else CNTRY
END AS CNTRY
FROM bronze.erp_loc_a101;

select * from silver.erp_loc_a101;




--
--insertion into silver.erp_pk_cat_g1v2
--

insert into silver.erp_pk_cat_g1_v2(
ID,
CAT,
SUBCAT,
MAINTENANCE
)

select
ID,
CAT,
SUBCAT,
MAINTENANCE
FROM bronze.erp_pk_cat_g1_v2;

select * from silver.erp_pk_cat_g1_v2;

-----------------------------------------------------------------------------------------------------------------------------------------------------