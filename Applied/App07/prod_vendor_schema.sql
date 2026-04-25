/*

   Database Teaching Team
   DML Applied Task Product Vendor schema file

*/

-- drop tables
DROP TABLE product CASCADE CONSTRAINTS PURGE;

DROP TABLE vendor CASCADE CONSTRAINTS PURGE;

-- create product table
CREATE TABLE product (
    prod_no     NUMBER(4) NOT NULL,
    prod_name   VARCHAR2(50) NOT NULL,
    prod_price  NUMBER(6, 2) NOT NULL,
    prod_stock  NUMBER(3) NOT NULL,
    vendor_id   NUMBER(3) NOT NULL
);

COMMENT ON COLUMN product.prod_no IS
    'product number (unique for each product)';

COMMENT ON COLUMN product.prod_name IS
    'product name';

COMMENT ON COLUMN product.prod_price IS
    'product price';

COMMENT ON COLUMN product.prod_stock IS
    'product on hold (stock)';

COMMENT ON COLUMN product.vendor_id IS
    'vendor id (unique for each vendor)';

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( prod_no );

-- create vendor table
CREATE TABLE vendor (
    vendor_id     NUMBER(3) NOT NULL,
    vendor_name   VARCHAR2(50) NOT NULL,
    vendor_phone  CHAR(10) NOT NULL
);

COMMENT ON COLUMN vendor.vendor_id IS
    'vendor id (unique for each vendor)';

COMMENT ON COLUMN vendor.vendor_name IS
    'vendor name';

COMMENT ON COLUMN vendor.vendor_phone IS
    'vendor phone';

ALTER TABLE vendor ADD CONSTRAINT vendor_pk PRIMARY KEY ( vendor_id );

ALTER TABLE vendor ADD CONSTRAINT vendor_un UNIQUE ( vendor_name );

-- add FK constraint
ALTER TABLE product
    ADD CONSTRAINT vendor_product_fk FOREIGN KEY ( vendor_id )
        REFERENCES vendor ( vendor_id );
