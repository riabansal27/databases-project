/*

   Database Teaching Team
   PLSQL Applied Task Product Vendor Order schema file

*/

-- drop tables
DROP TABLE product CASCADE CONSTRAINTS PURGE;
DROP TABLE purchase_order CASCADE CONSTRAINTS PURGE;
DROP TABLE purchase_order_item CASCADE CONSTRAINTS PURGE;
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

-- create purchase_order table
CREATE TABLE purchase_order (
    po_id      NUMBER(6) NOT NULL,
    vendor_id  NUMBER(3) NOT NULL,
    po_date    DATE      NOT NULL,
    po_status  CHAR(1)  DEFAULT 'P' NOT NULL,
    po_total_cost NUMBER(10,2) DEFAULT 0 NOT NULL 
);

comment on column purchase_order.po_id IS
    'purchase order id (unique for each purchase order)';
comment on column purchase_order.vendor_id IS
    'vendor id (unique for each vendor)';
comment on column purchase_order.po_date IS
    'purchase order date';
comment on column purchase_order.po_status IS
    'purchase order status P=Pending, C=Completed';
comment on column purchase_order.po_total_cost IS
    'total cost of the purchase order';

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_pk PRIMARY KEY (po_id);

Alter table purchase_order
    ADD CONSTRAINT purchase_order_status_ck CHECK (po_status IN ('P', 'C'));    

-- create purchase_order_item table
CREATE TABLE purchase_order_item (
    po_id      NUMBER(6) NOT NULL,
    prod_no    NUMBER(4) NOT NULL,
    po_prod_qty  NUMBER(5) NOT NULL,
    po_prod_unit_cost  NUMBER(6,2) NOT NULL
);

COMMENT ON COLUMN purchase_order_item.po_id IS
    'purchase order id (unique for each purchase order)';   
COMMENT ON COLUMN purchase_order_item.prod_no IS
    'product number (unique for each product)';
COMMENT ON COLUMN purchase_order_item.po_prod_qty IS
    'purchase order product quantity';
COMMENT ON COLUMN purchase_order_item.po_prod_unit_cost IS
    'product unit cost at time of order';

ALTER TABLE purchase_order_item
    ADD CONSTRAINT purchase_order_item_pk PRIMARY KEY (po_id, prod_no);

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

-- add FK constraints
ALTER TABLE product
    ADD CONSTRAINT vendor_product_fk FOREIGN KEY ( vendor_id )
        REFERENCES vendor ( vendor_id );

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_vendor_fk FOREIGN KEY (vendor_id)
        REFERENCES vendor (vendor_id);

ALTER TABLE purchase_order_item
    ADD CONSTRAINT poi_po_fk FOREIGN KEY (po_id)
        REFERENCES purchase_order (po_id);

ALTER TABLE purchase_order_item
    ADD CONSTRAINT poi_product_fk FOREIGN KEY (prod_no)
        REFERENCES product (prod_no);

--Sample data for the above schema

-- Insert vendor data (5 vendors)
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) VALUES (101, 'TechSupply Co', '0398765432');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) VALUES (102, 'Global Parts Ltd', '0287654321');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) VALUES (103, 'Premium Electronics', '0397654321');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) VALUES (104, 'Budget Supplies', '0296543210');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) VALUES (105, 'Quality Distributors', '0395432109');

-- Insert product data (10 products)
-- Vendor 101: 3 products (1 with stock < 10)
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (1, 'USB Cable 2m', 15.99, 45, 101);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (2, 'HDMI Cable 1.5m', 22.50, 8, 101);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (3, 'Power Adapter 65W', 35.00, 25, 101);

-- Vendor 102: 2 products
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (4, 'Keyboard Mechanical', 89.99, 12, 102);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (5, 'Mouse Wireless', 45.50, 9, 102);

-- Vendor 103: 3 products
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (6, 'Monitor 24 inch', 199.99, 18, 103);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (7, 'Webcam HD', 65.00, 22, 103);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (8, 'Headphones Noise Cancel', 129.95, 15, 103);

-- Vendor 104: 2 products
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (9, 'USB Hub 4 Port', 28.75, 30, 104);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) VALUES (10, 'Screen Protector Pack', 12.99, 50, 104);

-- Vendor 105: No products (0 products)

-- Insert purchase order data
-- Purchase orders from vendors 101, 102, 103, 104 (not from vendor 105 since they have no products)
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (1, 101, TO_DATE('2026-01-05', 'YYYY-MM-DD'), 'C');
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (2, 101, TO_DATE('2026-01-12', 'YYYY-MM-DD'), 'P');
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (3, 102, TO_DATE('2026-01-08', 'YYYY-MM-DD'), 'C');
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (4, 103, TO_DATE('2026-01-15', 'YYYY-MM-DD'), 'P');
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (5, 104, TO_DATE('2026-01-20', 'YYYY-MM-DD'), 'C');
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (6, 102, TO_DATE('2026-01-25', 'YYYY-MM-DD'), 'P');
INSERT INTO purchase_order (po_id, vendor_id, po_date, po_status) VALUES (7, 103, TO_DATE('2026-01-28', 'YYYY-MM-DD'), 'C');

-- Insert purchase order items
-- PO 1 (Vendor 101)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (1, 1, 50, 15.99);
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (1, 2, 30, 22.50);

-- PO 2 (Vendor 101)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (2, 3, 20, 35.00);

-- PO 3 (Vendor 102)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (3, 4, 15, 89.99);
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (3, 5, 25, 45.50);

-- PO 4 (Vendor 103)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (4, 6, 10, 199.99);
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (4, 7, 20, 65.00);

-- PO 5 (Vendor 104)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (5, 9, 40, 28.75);

-- PO 6 (Vendor 102)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (6, 4, 10, 89.99);

-- PO 7 (Vendor 103)
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (7, 8, 12, 129.95);
INSERT INTO purchase_order_item (po_id, prod_no, po_prod_qty, po_prod_unit_cost) VALUES (7, 6, 5, 199.99);

-- Update existing purchase orders to set the correct total cost
-- Update existing purchase orders to set the correct total cost
UPDATE purchase_order po
SET po.po_total_cost =
    (
        SELECT SUM(poi.po_prod_qty * poi.po_prod_unit_cost)
        FROM purchase_order_item poi
        WHERE poi.po_id = po.po_id
    );

COMMIT;