--
--GOLD LAYER 
--

--PRODUCT DIMENSION TABLE

CREATE VIEW gold.dim_products as
SELECT 
ROW_NUMBER() OVER (ORDER BY prd_id) as product_key,
pn.prd_id as product_id,
pn.prd_key as product_no,
pn.prd_nm as product_name,
pn.cat_id as category_id,
pc.CAT as category,
pc.SUBCAT as subcategory,
pc.MAINTENANCE,
pn.prd_cost as cost,
pn.prd_line as product_line,
pn.prd_start_dt as strt_date

FROM silver.crm_prd_info as pn
left join silver.erp_pk_cat_g1_v2 as pc
on pn.cat_id = pc.ID

where pn.prd_end_dt is null;