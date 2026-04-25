/*

   Database Teaching Team
   DML Applied Task Test script

*/

set echo on
spool prod_vendor_details.txt

-- describe tables
desc product;
desc vendor;

-- show data inserted
select * from vendor order by vendor_id;
select * from product order by prod_no;

SELECT '1. VENDOR Rows (5 required): ' AS "Table Loaded",
       COUNT(*)
  FROM vendor
UNION
SELECT '2. PRODUCT Rows (10 required): ',
       COUNT(*)
  FROM product;

-- Vendors without products
select 'Vendor without products' as vendor_details, vendor_id
from vendor where vendor_id not in (select vendor_id from product)
order by vendor_id;

-- products with stock < 10
SELECT PROD_NO,
    PROD_NAME,
    PROD_PRICE,
    prod_stock
 FROM PRODUCT
 where prod_stock < 10
    order by prod_stock;

set echo OFF
spool OFF

