/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'bronze.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--- Check for unwanted spaced
SELECT 
cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT 
cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT 
cst_marital_status
FROM bronze.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status);

SELECT 
cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

--- Data Standardization and consistancy
SELECT  DISTINCT cst_gndr
FROM bronze.crm_cust_info;

SELECT  DISTINCT cst_marital_status
FROM bronze.crm_cust_info;

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Expectation: No Results

-- Check for NULLs or Duplicates in Primary Key
SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--- Check for unwanted spaced
SELECT 
cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT 
cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT 
cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status);

SELECT 
cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

--- Data Standardization and consistancy
-- Expectation: No Results
SELECT  DISTINCT cst_gndr
FROM silver.crm_cust_info;

SELECT  DISTINCT cst_marital_status
FROM silver.crm_cust_info;

-- ====================================================================
-- Checking 'bronze.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key

SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--- Check for unwanted spaces
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--- Check for NULLs or Negative Numbers
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--- Data Standardization and Normalization
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--- Check for invalid data
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
--- Expecation: No result

-- Check for NULLs or Duplicates in Primary Key
SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--- Check for unwanted spaces
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--- Check for NULLs or Negative Numbers
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--- Data Standardization and Normalization
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

--- Check for invalid data
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

/* 
=======================================================
			  bronze.crm_sales_details
=======================================================
*/
--- Check for invalid dates
SELECT 
NULLIF(sls_order_dt,0) AS sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_order_dt) != 8
OR LEN(sls_order_dt) > 20500101
OR LEN(sls_order_dt) < 19000101

SELECT 
NULLIF(sls_ship_dt,0) AS sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0
OR LEN(sls_ship_dt) != 8
OR LEN(sls_ship_dt) > 20500101
OR LEN(sls_ship_dt) < 19000101

SELECT 
NULLIF(sls_due_dt,0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) != 8
OR LEN(sls_due_dt) > 20500101
OR LEN(sls_due_dt) < 19000101

--- Check for invalid date orders
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_ship_dt

--- Check Data Consistancy: Between Sales, Quantity, and Price
--- >> Sales = Price X Quantity
--- >> Values must not be NULL, zero and negative

SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
	 THEN sls_quantity * ABS(sls_price)
	 ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0 
	 THEN sls_sales/ NULLIF(sls_quantity, 0)
	 ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

/* 
=======================================================
			  silver.crm_sales_details
=======================================================
*/
--- Expecation: No result

--- Check for invalid dates
SELECT 
NULLIF(sls_order_dt,0) AS sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_order_dt) != 8
OR LEN(sls_order_dt) > 20500101
OR LEN(sls_order_dt) < 19000101

SELECT 
NULLIF(sls_ship_dt,0) AS sls_ship_dt
FROM silver.crm_sales_details
WHERE sls_ship_dt <= 0
OR LEN(sls_ship_dt) != 8
OR LEN(sls_ship_dt) > 20500101
OR LEN(sls_ship_dt) < 19000101

SELECT 
NULLIF(sls_due_dt,0) AS sls_due_dt
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) != 8
OR LEN(sls_due_dt) > 20500101
OR LEN(sls_due_dt) < 19000101

--- Check for invalid date orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_ship_dt

--- Check Data Consistancy: Between Sales, Quantity, and Price
--- >> Sales = Price X Quantity
--- >> Values must not be NULL, zero and negative

SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

/* 
=======================================================
			  bronze.erp_cust_az12
=======================================================
*/

--- Identify out of date range
SELECT DISTINCT
bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

--- Data Standardization and Consistancy
SELECT DISTINCT 
gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12

/* 
=======================================================
			  silver.erp_cust_az12
=======================================================
*/
--- Expecation: No result

--- Identify out of date range
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

--- Data Standardization and Consistancy
SELECT DISTINCT 
gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM silver.erp_cust_az12

/* 
=======================================================
			  bronze.erp_loc_a101
=======================================================
*/

--- Check for Unwanted Spaces
SELECT
REPlACE(cid, '-','') AS cid,
cntry
FROM bronze.erp_loc_a101

--- Data Standardization and consistancy
SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry	

SELECT DISTINCT
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101
ORDER BY cntry	

/* 
=======================================================
			  silver.erp_loc_a101
=======================================================
*/
--- Expecation: No result

--- Check for Unwanted Spaces
SELECT
REPlACE(cid, '-','') AS cid,
cntry
FROM silver.erp_loc_a101

--- Data Standardization and consistancy
SELECT *
FROM silver.erp_loc_a101
ORDER BY cntry	

SELECT DISTINCT
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE TRIM(cntry)
END AS cntry
FROM silver.erp_loc_a101
ORDER BY cntry	

/* 
=======================================================
			  bronze.erp_px_cat_g1v2
=======================================================
*/
\
--- Check for unwanted spaces
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat!=TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

--- Data Standatdization and Consistancy
SELECT DISTINCT
cat
FROM bronze.erp_px_cat_g1v2

/* 
=======================================================
			  silver.erp_px_cat_g1v2
=======================================================
*/
--- Expecation: No result

--- Check for unwanted spaces
SELECT * FROM silver.erp_px_cat_g1v2
WHERE cat!=TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

--- Data Standatdization and Consistancy
SELECT DISTINCT
cat
FROM silver.erp_px_cat_g1v2
