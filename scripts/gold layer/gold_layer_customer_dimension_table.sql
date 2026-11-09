--
--GOLD LAYER
--

--CUSTOMER
-- this is a dimension table - customer dimension

CREATE VIEW gold.dim_customers AS 
select 
ROW_NUMBER() OVER (ORDER BY cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name, 
ci.cst_lastname as last_name, 
la.cntry as country,
ci.cst_material_status as marital_status, 
case
when ci.cst_gender != 'unknown' 
then ci.cst_gender
else COALESCE(ca.gen, 'unknown')
end as gender, 
ca.bdate as birthday,
ci.cst_create_date as create_date
from silver.crm_cust_info as ci
left join
silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
left join 
silver.erp_loc_a101 as la
on ci.cst_key = la.cid;
--