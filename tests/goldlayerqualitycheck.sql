--
--GOLD LAYER QUALITY CHECK
--


--CUSTOMERS DIMENSION TABLE

--duplicate check
select cst_id, count(*) from
(select 
ci.cst_id,
ci.cst_key,
ci.cst_firstname, 
ci.cst_lastname, 
ci.cst_material_status, 
ci.cst_gender, 
ci.cst_create_date,
ca.bdate,
ca.gen,
la.cntry
from silver.crm_cust_info as ci
left join
silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
left join 
silver.erp_loc_a101 as la
on ci.cst_key = la.cid)t
group by cst_id
having count(*) >1;


--data integration check on gender
select distinct
ci.cst_gender, 
ca.gen
from silver.crm_cust_info as ci
left join
silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
left join 
silver.erp_loc_a101 as la
on ci.cst_key = la.cid
order by 1,2;

--solution for the problem
select distinct
case
when ci.cst_gender != 'unknown' 
then ci.cst_gender
else COALESCE(ca.gen, 'unknown')
end
from silver.crm_cust_info as ci
left join
silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
left join 
silver.erp_loc_a101 as la
on ci.cst_key = la.cid;




--product

--duplicate check
select product_id, count(*) from
(SELECT 
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
where pn.prd_end_dt is null)t
group by product_id
having count(*) >1;




--SALES FACT TABLE

--FACT CHECK
select * from
gold.fact_sales as f
left join gold.dim_customers as c
on f.customer_key = c.customer_key
where c.customer_key is null;