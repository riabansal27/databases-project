/*
    Student Name: Ria Bansal
    Student ID: rban0019
    Date: 25-Apr-2026
    
    AI Used: GitLab Duo
    Prompt used: "Generate SQL INSERT statements for the VENDOR and PRODUCT 
    tables defined in this schema. Requirements: Insert 5 vendors, Insert 10 
    products, 2 vendors must have no products, At least 2 products must have 
    prod_stock below 10, Use realistic product and vendor names"
*/

SET ECHO ON
SPOOL prod_vendor_details.txt

-- Insert 5 vendors
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) 
VALUES (101, 'TechSupply Co', '5551234567');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) 
VALUES (102, 'Global Electronics', '5552345678');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) 
VALUES (103, 'Office Essentials Ltd', '5553456789');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) 
VALUES (104, 'Premium Hardware Inc', '5554567890');
INSERT INTO vendor (vendor_id, vendor_name, vendor_phone) 
VALUES (105, 'Digital Solutions Group', '5555678901');

-- Insert 10 products (vendors 104 and 105 have no products)
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1001, 'Wireless Mouse', 29.99, 45, 101);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1002, 'USB-C Cable', 12.50, 5, 101);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1003, 'Mechanical Keyboard', 89.99, 22, 101);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1004, 'LED Monitor 24 inch', 199.99, 15, 102);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1005, 'Laptop Stand', 34.99, 8, 102);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1006, 'Webcam HD', 59.99, 30, 102);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1007, 'Desk Organizer', 18.75, 50, 103);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1008, 'Ergonomic Chair Mat', 45.00, 12, 103);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1009, 'Notebook Set', 15.99, 3, 103);
INSERT INTO product (prod_no, prod_name, prod_price, prod_stock, vendor_id) 
VALUES (1010, 'Wireless Headset', 79.99, 18, 101);

COMMIT;

SET ECHO OFF
SPOOL OFF